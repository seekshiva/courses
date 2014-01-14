jQuery ->
  class CourseModel extends Backbone.Model
    paramRoot: 'course'

    defaults:
      name:        null
      credits:     null
      about:       null
      latest_term: null
      topics:      null

    urlRoot: "/courses/"

  @app = window.app ? {}
  @app.CourseModel = CourseModel
