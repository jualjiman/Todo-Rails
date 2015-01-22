class TodoItemsController < ApplicationController 
	#acciones que se ejecutaran antes de la ejecucion de alguna otra accion
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create] #exceptuando la ejecucion para alguna accion especifica

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params) #creando un item usando el metodo todo_item_params
		redirect_to @todo_list #redireccionando hacia una ruta
	end

	def destroy 
		#ya esta definido el @todo_item, gracias al metodo "set_todo_item" configurado en el before_action
		if @todo_item.destroy #si fue posible destruir el item previamente enfocado, entonces..
			flash[:success] = "Todo List item was deleted" 
		else
			flash[:error] = "Todo List item was not deleted"
		end
		redirect_to @todo_list #redirecciono a...
	end

	def complete 
		#de igual manera ya se tiene enfocado el @todo_item con el metodo set_todo_item
		@todo_item.update_attribute(:completed_at, Time.now) #cambio el atributo completed_at, con la fechahora actual
		redirect_to @todo_list, notice: "Todo item completed" #una redireccion con mensaje
	end
	#==========================================================================================
	#metodos privados
	private 
	
	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id]) #encuentro de entre los todo_lists el que tenga un id especificado, y lo deposito en @todolist
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id]) # encuentro del todo_list encontrado anteriormente, de entre sus todo_items, el que tenga el id especifico
	end

	def todo_item_params
		params[:todo_item].permit(:content)	#simplemente le digo que le estoy pasando un objeto tipo todo_item, y que le estoy permitiendo pasar el atributo content
	end
end
