jQuery ->
  class DepartmentModel extends Backbone.Model
    paramRoot: 'department'

    defaults:
      name:          null
      hod:           null
      short:         null
      rollno_prefix: null
      terms:         null

    urlRoot: "/departments/"

  class DepartmentsCollection extends Backbone.Collection
    model: DepartmentModel
    url: "/departments/"

  class CourseModel extends Backbone.Model
    paramRoot: 'course'

    defaults:
      name:        null
      credits:     null
      about:       null
      latest_term: null
      topics:      null

    urlRoot: "/courses/"

  class TermModel extends Backbone.Model
    paramRoot: 'term'

    defaults:
      name:        null
      credits:     null
      about:       null
      latest_term: null
      topics:      null

    urlRoot: "/terms/"

  class TopicModel extends Backbone.Model
    paramRoot: 'topic'

    defaults:
      title:       null

    urlRoot: "/topics/"

  class SubscriptionModel extends Backbone.Model
    paramRoot: 'subscription'

    defaults:
      term_id:     null
      user_id:     null
      attending:   null

    urlRoot: "/subscriptions/"

  class ProfileModel extends Backbone.Model
    paramRoot: 'user'

    defaults:
      id:     null
      name:   null
      phone:  null
      email:  null

    urlRoot: "/profile/"

   
  @app                       = window.app ? {}
  
  @app.DepartmentModel       = DepartmentModel
  @app.CourseModel           = CourseModel
  @app.TermModel             = TermModel
  @app.SubscriptionModel     = SubscriptionModel
  @app.ProfileModel          = ProfileModel

  @app.DepartmentsCollection = DepartmentsCollection
