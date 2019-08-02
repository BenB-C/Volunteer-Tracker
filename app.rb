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
  project = Project.find(params[:id])
  project.update({:title => params[:title]})
  redirect to "projects/#{project.id}"
end

delete('/projects/:id/delete') do
  project = Project.find(params[:id])
  project.delete
  redirect to 'projects'
end

post('/projects/:id/new_volunteer') do
  project = Project.find(params[:id])
  name = params[:name]
  if name != ""
    Volunteer.new({:name => params[:name], :project_id => project.id}).save
  end
  redirect to "projects/#{project.id}"
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id])
  erb(:volunteer)
end

patch('/volunteers/:id/edit') do
  volunteer = Volunteer.find(params[:id])
  volunteer.update({:name => params[:name], :project_id => params[:project_id]})
  redirect to "volunteers/#{volunteer.id}"
end

delete('/volunteers/:id/delete') do
  volunteer = Volunteer.find(params[:id])
  project_id = volunteer.project_id
  volunteer.delete
  redirect to "projects/#{project_id}"
end
