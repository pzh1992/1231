module ApplicationHelper
  
  def is_admin?
    current_user.try(:status) == "admin"
  end

  def on?(article)
    article.try(:status) == "on"
  end

  def video_on?(article)
    article.try(:video_status) == "on"
  end

  def will_page_next?(article_id, category_id)
    array = Article.where(category_id: category_id, status: "on").order("weight asc").pluck(:id)
    array.last != article_id.to_i
  end

  def will_page(article_id, category_id)
    array = Article.where(category_id: category_id, status: "on").order("weight asc").pluck(:id)
    if array.last == article_id.to_i
      id = array.first
    else
      id = array[array.index(article_id.to_i).to_i + 1]
    end
    return id
  end

  def will_page_prev?(article_id, category_id)
    array = Article.where(category_id: category_id, status: "on").order("weight asc").pluck(:id)
    array.first != article_id.to_i
  end

  def will_page_lower(article_id, category_id)
    array = Article.where(category_id: category_id, status: "on").order("weight asc").pluck(:id)
    if array.first == article_id.to_i
      id = array.first
    else
      id = array[array.index(article_id.to_i).to_i - 1]
    end
    return id
  end

  def exercise_name?(article)
    article.exercise_name.present?
  end

end
