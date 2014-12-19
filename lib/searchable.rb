module Searchable
  # Query your ActiveRecord models.
  #
  # Post.search 'foo', [:title, :summary]

  def searchable_by(*column_names)
    @search_columns = [column_names].flatten
  end

  def search(query, fields=nil, options={})
    where( search_conditions(query, fields) ).scoping do
      where( options )
    end
  end

  #[
  # (LOWER(first_name) LIKE :word1 OR LOWER(last_name) LIKE :word1) AND
  # (LOWER(first_name) LIKE :word2 OR LOWER(last_name) LIKE :word2) AND
  # (LOWER(first_name) LIKE :word3 OR LOWER(last_name) LIKE :word3) AND
  # (LOWER(first_name) LIKE :word4 OR LOWER(last_name) LIKE :word4),
  # {:word1=>"%juan%", :word2=>"%ruiz%", :word3=>"%ana%", :word4=>"%quintana%"} ]
  def search_conditions(query, fields=nil)
    return nil if query.blank?
    fields ||= @search_columns

    # split the query by commas as well as spaces, just in cases
    words = query.split(',').map(&:split).flatten

    binds = {}
    or_fragments = []
    words.inject(1) do |count, word|
      like_fragments = [fields].flatten.map{ |field| "LOWER(#{field}) LIKE :word#{count}"}
      or_fragments << "(#{like_fragments.join(' OR ')})"
      binds["word#{count}".to_sym] = "%#{word.to_s.downcase}%"
      count += 1
    end

    [or_fragments.join(' AND '), binds]
  end
end

ActiveRecord::Base.extend Searchable
