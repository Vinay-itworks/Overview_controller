class SkillsController < ApplicationController
  def index
    @skills = User.find(params["user_id"]).skills
    # puts @skills
  end

  def create
    # puts "Params #{params}"
    @user = User.find(params["user_id"])
    # puts ("Skill params: #{skill_params}")
    @skill = Skill.where(name: skill_params["name"]).where(rating: skill_params["rating"])

    # puts "SKill check : #{@skill.inspect}"
    @user_skills = @user.skills.ids
    unless @skill == []
      unless @skill.first.id.in? @user_skills
        @user.skills << @skill.first
      else
        return redirect_to user_url(@user), notice: "Skill is already added to User."
      end
    else
      @user.skills << Skill.new(skill_params)
    end
    redirect_to user_url(@user), notice: "Skill was added successfully to User."
    # respond_to do |format|
    #   if @skill.valid?
    #     format.html { redirect_to user_url(@user), notice: "Skill was add successfully to User." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @skill.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def new
    # head :unauthorized
    @user = User.find(params["user_id"])
    @skill =  @user.skills.new
  end

  def edit
    
  end

  def show
    puts "Params #{params}"
    @skill = User.find(params["user_id"]).skills.where(id: params["id"])

  end

  def update
    
  end

  def destroy
    
  end

  private
  def skill_params
    params.require(:skill).permit(:name, :rating)
  end

end