defmodule LiveViewTodos.TodoLive do
    use Phoenix.LiveView
    alias LiveViewTodos.Todos
    alias LiveViewTodosWeb.TodoView

    def render(assigns) do
        TodoView.render("todo.html" , assigns) 
    end
      
    #   def render(assigns) do 
    #     PageView.render("count.html" , assigns) 
    #   end 
    
    def mount(_session, socket) do
        Todos.subscribe()
        {:ok, assign(socket, todos: Todos.list_todos()  )}
    end
            

    def handle_info({Todos,[ :todo| _ ],_},socket) do
        {:noreply, assign(socket, todos: Todos.list_todos() )}
    end

    def handle_event("add", %{"todo" => todo} , socket)  do
    # IO.puts todo
        Todos.create_todo(todo)
        {:noreply, assign(socket, todos: Todos.list_todos() )}
    end


    def handle_event("toggle",  %{"id" => todoid} , socket)  do
    # IO.puts todo
        uptodo =  Todos.get_todo!(todoid)
        Todos.update_todo(uptodo , %{done: !uptodo.done })
        {:noreply, socket}
    end

    def handle_event("delete",  %{"id" => todoid} , socket)  do
        # IO.puts todo
            # uptodo =  Todos.get_todo!(todoid)
            Todos.delete_todo(todoid)
            {:noreply, socket}
        end

end