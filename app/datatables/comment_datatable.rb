class CommentDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::WillPaginate

  def_delegator :@view, :link_to
  def_delegator :@view, :h
  def_delegator :@view, :mail_to 
  def_delegator :@view, :backend_comment_path
  def_delegator :@view, :edit_backend_comment_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
      'Comment.id',
      'Comment.body',
      'User.name_user',
      'Article.title',
      'Comment.created_at'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
      'Comment.id',
      'Comment.body',
      'User.name_user',
      'Article.title',
      'Comment.created_at'
    ]
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.id,
        record.body.truncate(20),
        record.user.name_user,
        record.article.title.truncate(20),
        record.created_at.strftime("%FT%R"),
        record.approve,
        link_to("show",backend_comment_path(record)),
        link_to("edit", "#{}","data-toggle" => "modal","data-target" => "#myModalEdit","id" => "comment-edit-"+ "#{record.id}",class: "modal-edit"),
        link_to("delete", backend_comment_path(record),method: :delete)
      ]
    end
  end

  def get_raw_records
    # insert query here
    if options[:user].has_role? :member
     Comment.where(user_id: options[:user].id).joins(:article,:user)
    else
     Comment.joins(:article,:user)
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
