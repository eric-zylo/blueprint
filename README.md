# Project Title

## Hosted Application Link
[Link to your hosted application (if available)](https://screenbetter.online/)

## Instructions for Running the Code Locally
1. Clone the repository: 
    ```bash
    git clone https://github.com/eric-zylo/blueprint.git
    ```
2. Install the required dependencies:
    ```bash
    bundle install
    yarn install
    ```
3. Setup the database:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```
4. Start the application:
    ```bash
    bin/dev
    ```

## Description of the Problem and Solution
### Problem
Therapists often face the challenge of determining which screenings are most relevant for their patients, a process that can be time-consuming and complex. This application simplifies that process by allowing therapists to create and store various pre-assessments. By scoring patient responses, the system helps guide therapists in selecting the most appropriate follow-up assessments, streamlining decision-making and saving valuable time.

### Solution
Therapists can easily create patient profiles, assign pre-assessments, and follow-up assessments based on the results of the screenings. Patients receive a secure, tokenized link via email to complete the assessment without needing to sign up. After submission, the system scores responses and recommends follow-up assessments, helping therapists focus on actionable insights.

## Reasoning Behind Your Technical Choices
1. **Ruby on Rails**: Provides quick backend development with built-in support for authentication, routing, and database management.
2. **React**: Used for dynamic UI components like the diagnostic screener to improve the user experience with state management.
3. **PostgreSQL**: Chosen for its robustness, scalability, and support for UUIDs to ensure unique patient records.
4. **React on Rails**: For seamless integration between React components and Rails views, improving maintainability without fully transitioning to an SPA.
5. **Sidekiq**: Handles background email tasks asynchronously, improving performance by offloading long-running tasks like email notifications.

## Production Deployment
### Deployment Strategy
Platform: Render. It provides full-stack support for Rails and React and integrates with background job processing using Sidekiq.

### Deployment Steps
- Set up environment variables for sensitive data (DATABASE_URL, SECRET_KEY_BASE, etc.).
- Automatically handled SSL via Render’s built-in security features.
- Run Rails commands for migration and assets precompilation during deployment.
- Set up Sidekiq for background job processing.
- Configure React build using Webpacker (or Shakapacker) during the deployment process.

### Scaling & Caching
- Horizontal scaling using Render's auto-scaling features.
- Redis for caching expensive database queries and background jobs.

## High Availability and Performance
Implemented Redis for caching and background job management, reducing database load. Render’s auto-scaling ensures that the app can handle peak traffic without performance degradation.

## Security
Render provides SSL/TLS encryption, and I’ve used Devise for secure authentication. Pundit ensures proper authorization, while UUIDs and tokenized routes obfuscate sensitive data. All sensitive data is encrypted at rest, and communications are protected over HTTPS.

## Troubleshooting and Monitoring
Used Render’s built-in logging for error tracking. For further scalability, tools like Datadog could be implemented for performance monitoring and issue detection.

## Trade-Offs and Potential Improvements
The main trade-off was focusing on database architecture rather than fully polishing the front-end. With more time, I would implement a more polished user experience using a single-page application (SPA) model and advanced JavaScript frameworks.

## Code You’re Proud Of
I’m particularly proud of how the models are structured to ensure scalability and maintainability, especially with the way relationships and data integrity are managed. [View the models directory here](https://github.com/eric-zylo/blueprint/tree/main/app/models).

### Link to Resume or Public Profile
You can view my LinkedIn profile here: [Eric Scharnak - LinkedIn](https://www.linkedin.com/in/eric-scharnak-86609b76/)
