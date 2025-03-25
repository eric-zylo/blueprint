class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_patient, only: [:edit, :update, :destroy]
  after_action :verify_authorized, only: [:edit, :update, :destroy]
  after_action :verify_policy_scoped, only: [:index]

  def index
    @patients = policy_scope(@user.patients)
  end

  def new
    @patient = current_user.patients.new
  end

  def create
    @patient = current_user.patients.new(patient_params)
  
    if @patient.save
      redirect_to user_patients_path(current_user), notice: 'Patient created successfully.'
    else
      render :new, alert: 'Error creating patient.'
    end
  end

  def edit
    authorize @patient
  end

  def update
    authorize @patient

    if @patient.update(patient_params)
      redirect_to user_patients_path(@user), notice: 'Patient updated successfully.'
    else
      render :edit, alert: 'Error updating patient.'
    end
  end

  def destroy
    authorize @patient
    if @patient.destroy
      redirect_to user_patients_path(@user), notice: 'Patient deleted successfully.'
    else
      redirect_to user_patients_path(@user), alert: 'Error deleting patient.'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_patient
    @patient = @user.patients.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email)
  end
end
