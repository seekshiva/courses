jQuery ->
  class DepartmentsView extends Backbone.View
    el: "#content"
    template: Handlebars.compile($("#departments-template").html())

    initialize: ->
      @app = window.app ? {}
      @app.departments = @app.controller.getCollection("departments_collection")
      @app.departments.bind "reset", @render, @
      @

    render: ->
      depts = {}

      @app.departments.models.map (dept) ->
        depts[dept.id] = {
          id: dept.get("id")
          name: dept.get("name")
          hod: dept.get("hod")
        }

      $(@el).html @template
        depts: depts


      @

  class DepartmentView extends Backbone.View
    template: Handlebars.compile($("#department-template").html())

    el: "#content"

    initialize: (options) ->
      @options = options
      @app = window.app ? {}
      @model = @app.DepartmentModel

      @app.departments = @app.controller.getCollection("departments_collection")
      @app.departments.bind "reset", @render, @

    render: =>
      dept = @app.departments._byId[@options.id]
      dept = {
        id: dept.get("id")
        short: dept.get("short")
        name: dept.get("name")
        hod: dept.get("hod")
      }

      $(@el).html @template
        dept: dept

      return this


  class Courses.Views.ShowView extends Backbone.View
    template: JST["backbone/templates/departments/show"]

    render: ->
      @$el.html(@template(@model.toJSON() ))
      return this


  @app = window.app ? {}
  @app.DepartmentsView = DepartmentsView
  @app.DepartmentView = DepartmentView

