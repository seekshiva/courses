jQuery ->
  class DepartmentsView extends Backbone.View
    el: "#content"
    template: Handlebars.compile($("#departments-template").html())

    initialize: ->
      @app = window.app ? {} 
      @departments = new @app.DepartmentsCollection()  
      @departments.bind "reset", @render, @
      @departments.fetch()
      @

    render: ->
      depts = {}

      _.map( @departments.models, (dept) ->
        depts[dept.id] = {
          id: dept.get("id")
          name: dept.get("name")
          hod: dept.get("hod")
          hod_email: dept.get("hod_email")
          short: dept.get("short")
        }
      )

      $(@el).html @template
        depts: depts

      $(@el).find("a").click @app.show_local_page

      @

  @app = window.app ? {}
  @app.DepartmentsView = DepartmentsView
