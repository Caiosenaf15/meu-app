module ApplicationHelper
    def render_if(condition, template, record)
        render template, record if condition
      
    end

    def sub_masked_email(email)
        email.gsub(/(?<=.{2}).*@.*(?=\S{2})/, '****@****')
    end
    
    def month_day_year(datetime)
        datetime.strftime("%B %e, %Y")
    end
end
