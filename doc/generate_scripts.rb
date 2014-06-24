rails g scaffold ParentCompany name:uniq additional_name:uniq
rails g model FeedStatus name
rails g model FeedFrequency name
rails g model FeedType name
rails g scaffold Feed name notes:text stage_feed_url production_feed_url production_start_date:datetime production_end_date:datetime company:references feed_status:references feed_frequency:references feed_type:references
