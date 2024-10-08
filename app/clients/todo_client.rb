class TodoClient
  include HTTParty
  
  BASE_URL = "http://jsonplaceholder.typicode.com/todos"
  
  def create(params)
    begin
      todo = Todo.new.attributes
      todo.delete("id")
  
      todo["title"] = params["title"]
      todo["userId"] = params["userId"]
      todo["completed"] = params["completed"]
    
      if Todo::NUMERIC_STRING.match?(todo["userId"].to_s) && Todo::BOOLEAN_STRINGS.include?(params["completed"])
        data = HTTParty.post(BASE_URL, todo)

        {
          :base_url => BASE_URL,
          :status => Status::MESSAGES[200],
          :code => 200,
          :message => "Todo created",
          :todo => data.merge!(todo)
        }

      else
        raise StandardError, "data integrity error"
      end
    rescue Exception => e

      {
        :base_url => BASE_URL,
        :status => Status::MESSAGES[422],
        :code => 422,
        :message => "Todo not created",
        :todo => todo,
        :details => e,
        :backtrace => e.backtrace
      }

    end
  
  
    
  end
  
  # despite different prefix, end controller method name with familiar action
  def recent_200
    data = JSON.parse(HTTParty.get(BASE_URL).body)
    {
      :base_url => BASE_URL,
      :status => Status::MESSAGES[200],
      :code => 200,
      :message => "Most recent 200 retrieved",
      :data => data
    }
  end
  
  def delete(id)
  
    begin

      if !Todo::NUMERIC_STRING.match?(id.to_s)
        raise StandardError, "id not a number"
      end
  
      data = HTTParty.delete("#{BASE_URL}/#{id}")
  
      { 
        :base_url => BASE_URL,
        :status => Status::MESSAGES[202],
        :code => 202,
        :message => "Todo with id (#{id}) deleted",
        :data => data
      }
    rescue Exception => e
      { 
        :base_url => BASE_URL,
        :status => Status::MESSAGES[405],
        :code => 405,
        :message => "Todo with id (#{id}) not deleted",
        :details => e
      }
    end
  end
  
  end