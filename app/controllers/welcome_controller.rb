class WelcomeController < ApplicationController
  # load_and_authorize_resource :class => false
  layout 'welcome'
  def index
		@worktypes = Worktype.all
    @order = Order.new
    @client = Client.new
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
  end

  def create_order
    @order = Order.new(order_params.except(:client))
    if current_user
      @order.client_id = current_user.id if current_user.role = "Client"
      if @order.save
        redirect_to root_path, notice: 'Заказ успешно создан.'
      else
        flash[:notice] = 'Ошибка'
        redirect_to root_path
      end
    else
      @client = Client.new(order_params[:client].merge({ activated: true }))
      @client.password = SecureRandom.hex
      if @client.save
        @order.client_id = @client.id
        token = @client.send(:set_reset_password_token)
          sms = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.phone}&mes=Здравствуйте,вы зарегестрировались на сайте www.redstudent.ru, к Вам на почту выслан Логин и пароль для входа. Ваш Редстудент")
          email = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.email}&mes=test&sender=3206297@mail.ru&subj=test&mail=1")
          uri = URI(email)
          url = URI(sms)
          a = Net::HTTP.get(uri)
          a = Net::HTTP.get(url)
        #UserMailer.delay.set_password_instructions(@client, token)
        if @order.save
          if params[:materials]
            params[:materials].each {|file| 
              @order.materials.create(document: file)}
          end
          sign_in(:user, @client)
          redirect_to dashboard_index_path, notice: 'Заказ создан. Вы получите на email инструкцию для задания пароля'
        else
          redirect_to root_path, notice: 'Ошибка'
        end
      else
        redirect_to root_path, notice: 'Такой email уже зарегистрирован в системе'
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:worktype_id, :worktype_other, :speciality_id, :speciality_other,
                                  :institution, :theme, :uniqueness, :document, :comment, :deadline,
                                  :page_number, { client: [:email, :phone] })
  end
end
