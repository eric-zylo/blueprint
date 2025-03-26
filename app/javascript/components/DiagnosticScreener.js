import React, { useState, useEffect } from 'react';
import axios from 'axios';

function DiagnosticScreener({ token, csrfToken }) {
  const [screenerData, setScreenerData] = useState(null);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [submissionError, setSubmissionError] = useState(null);
  const [submissionSuccess, setSubmissionSuccess] = useState(false);
  const [resultsData, setResultsData] = useState(null);
  const [completedMessage, setCompletedMessage] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`/api/v1/diagnostic_screener_instances/${token}.json`, {
          headers: {
            'X-CSRF-Token': csrfToken,
          },
        });
        setScreenerData(response.data);
        if (response.data.completed_at) {
          setCompletedMessage("This screener has already been completed.");
        }
      } catch (error) {
        console.error('Error fetching screener data:', error);
      }
    };

    fetchData();
  }, [token, csrfToken]);

  if (!screenerData) {
    return <div>Loading...</div>;
  }

  if (completedMessage) {
    return <div>{completedMessage}</div>;
  }

  if (!screenerData.content || !screenerData.content.sections || screenerData.content.sections.length === 0) {
    return <div>This screener is completed.</div>;
  }

  const currentQuestion = screenerData.content.sections[0].questions[currentQuestionIndex];
  const questionAnswers = screenerData.content.sections[0].answers;

  const handleAnswerChange = async (value) => {
    setAnswers({ ...answers, [currentQuestion.question_id]: value });

    if (currentQuestionIndex < screenerData.content.sections[0].questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    } else {
      try {
        const answersArray = Object.entries(answers).map(([questionId, value]) => ({
          question_id: questionId,
          value: parseInt(value, 10),
        }));

        const response = await axios.post(`/api/v1/diagnostic_screener_instances/score/${token}`, {
          answers: answersArray,
        }, {
          headers: {
            'X-CSRF-Token': csrfToken,
          },
        });

        console.log('Submission successful:', response.data);
        setResultsData(response.data);
        setSubmissionSuccess(true);
      } catch (error) {
        console.error('Error submitting answers:', error);
        setSubmissionError('There was an error submitting your answers. Please try again.');
      }
    }
  };

  if (submissionSuccess && resultsData) {
    return (
      <div>
        <h2>Scoring Results</h2>
        <table>
          <thead>
            <tr>
              <th>Domain</th>
              <th>Score</th>
              <th>Assessment Type</th>
            </tr>
          </thead>
          <tbody>
            {resultsData.results.map((result, index) => (
              <tr key={index}>
                <td>{result.domain}</td>
                <td>{result.score}</td>
                <td>{result.assessment_type}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {resultsData.assessments && resultsData.assessments.length > 0 && (
          <div>
            <h2>Triggered Assessments</h2>
            <ul>
              {resultsData.assessments.map((assessment, index) => (
                <li key={index}>{assessment}</li>
              ))}
            </ul>
          </div>
        )}
      </div>
    );
  }

  return (
    <div>
      <h2>{screenerData.full_name}</h2>
      <p>{screenerData.content.sections[0].title}</p>
      {submissionError && <p style={{ color: 'red' }}>{submissionError}</p>}

      {currentQuestion && (
        <div>
          <p>{currentQuestion.title}</p>
          <div>
            {questionAnswers.map((answer) => (
              <label key={answer.value}>
                <input
                  type="radio"
                  name={`question_${currentQuestion.question_id}`}
                  value={answer.value}
                  checked={answers[currentQuestion.question_id] === answer.value}
                  onChange={() => handleAnswerChange(answer.value)}
                />
                {answer.title}
              </label>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export default DiagnosticScreener;
