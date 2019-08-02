require './lib/project'
require './lib/volunteer'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
also_reload 'lib/**/*.rb'

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do
  redirect to '/projects'
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/new_project') do
  Project.new({:title => params[:title]}).save
  redirect to '/projects'
end

get('/projects/:id') do
  @project = Project.find(params[:id])
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id])
  erb(:edit_project)
end

patch('/projects/:id/edit') do
  @project = Project.find(params[:id])
  @project.update({:title => params[:title]})
  erb(:project)
end
