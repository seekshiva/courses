jQuery ->
  class DepartmentModel extends Backbone.Model
    paramRoot: 'department'

    defaults:
      name:          null
      hod:           null
      hod_email:     null
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

  class SectionModel extends Backbone.Model
    paramRoot: 'section'

    defaults:
      title:       null
      topics:      null

    urlRoot: "/sections/"

  class SectionsCollection extends Backbone.Collection
    model: SectionModel
    url: "/sections/"

  class TopicModel extends Backbone.Model
    paramRoot: 'topic'

    defaults:
      title:        null
      ct_status:    null
      description:  null

    urlRoot: "/topics/"

  class TopicsCollection extends Backbone.Collection
    model: TopicModel
    url: "/topics/"

  class ReferenceModel extends Backbone.Model
    paramRoot: "reference"

    defaults:
      term_id:      null
      book_id:      null
      title:        null

    urlRoot: "/references/"

  class TermDocumentModel extends Backbone.Model
    paramRoot: 'term_document'

    defaults:
      id:     null

    urlRoot: "/term_document/"

  class SectionDocumentModel extends Backbone.Model
    paramRoot: 'section_document'

    defaults:
      id:     null

    urlRoot: "/section_document/"

  class TopicDocumentModel extends Backbone.Model
    paramRoot: 'topic_document'

    defaults:
      id:     null

    urlRoot: "/topic_document/"

  class ReferencesCollection extends Backbone.Collection
    model: ReferenceModel
    url: "/references/"

  class SubscriptionModel extends Backbone.Model
    paramRoot: 'subscription'

    defaults:
      term_id:     null
      user_id:     null
      attending:   null

    urlRoot: "/subscriptions/"

  class SubscriptionsCollection extends Backbone.Collection
    model: SubscriptionModel
    url: "/subscriptions/"

  class ProfileModel extends Backbone.Model
    paramRoot: 'user'

    defaults:
      id:     null
      name:   null
      phone:  null
      email:  null
      type:   null

    urlRoot: "/profile/"

   
  @app                       = window.app ? {}
  
  @app.DepartmentModel       = DepartmentModel
  @app.CourseModel           = CourseModel
  @app.TermModel             = TermModel
  @app.SubscriptionModel     = SubscriptionModel
  @app.ProfileModel          = ProfileModel
  @app.SectionModel          = SectionModel
  @app.TopicModel            = TopicModel
  @app.ReferenceModel        = ReferenceModel
  @app.TermDocumentModel     = TermDocumentModel
  @app.SectionDocumentModel  = SectionDocumentModel
  @app.TopicDocumentModel    = TopicDocumentModel

  @app.DepartmentsCollection      = DepartmentsCollection
  @app.SubscriptionsCollection    = SubscriptionsCollection
  @app.SectionsCollection         = SectionsCollection
  @app.TopicsCollection           = TopicsCollection
  @app.ReferencesCollection       = ReferencesCollection