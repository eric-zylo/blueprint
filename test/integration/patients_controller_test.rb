require 'test_helper'

class PatientsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @other_user = create(:user)
    @patient = create(:patient, user: @user)
    @other_patient = create(:patient, user: @other_user)

    sign_in @user
  end

  def teardown
    sign_out :user
  end

  test 'should get index' do
    get user_patients_path(@user)
    assert_response :success
    assert_not_nil assigns(:patients)
  end

  test 'should get new' do
    get new_user_patient_path(@user)
    assert_response :success
    assert_not_nil assigns(:patient)
  end

  test 'should create patient' do
    assert_difference('Patient.count') do
      post user_patients_path(@user), params: { patient: attributes_for(:patient) }
    end

    assert_redirected_to user_patients_path(@user)
  end

  test 'should get edit' do
    get edit_user_patient_path(@user, @patient)
    assert_response :success
    assert_not_nil assigns(:patient)
  end

  test 'should update patient' do
    patch user_patient_path(@user, @patient), params: { patient: { first_name: 'Updated' } }
    assert_redirected_to user_patients_path(@user)
    @patient.reload
    assert_equal 'Updated', @patient.first_name
  end

  test 'should not get edit for other user\'s patient' do
    get edit_user_patient_path(@other_user, create(:patient, user: @other_user))
    assert_redirected_to authenticated_root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]
  end

  test 'should not update other user\'s patient' do
    patch user_patient_path(@other_user, create(:patient, user: @other_user)), params: { patient: { first_name: 'Updated' } }
    assert_redirected_to authenticated_root_path
    assert_equal 'You are not authorized to perform this action.', flash[:alert]
  end

  test "should only show current user's patients on index" do
    get user_patients_path(@user)
  
    assert_response :success

    patients = assigns(:patients)
    patient_user_ids = patients.pluck(:user_id)
    assert_equal 1, patients.size
    assert patient_user_ids.include?(@user.id)
    refute patient_user_ids.include?(@other_user.id)
  end

  test 'should require authentication' do
    sign_out @user
    get user_patients_path(@user)
    assert_redirected_to new_user_session_path
  end
end
