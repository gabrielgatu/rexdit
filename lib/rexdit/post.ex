defmodule Rexdit.Post do

  @type t :: %Rexdit.Post{}
  
  defstruct domain: nil,
            subreddit: nil,
            author: nil,
            thumbnail: nil,
            url: nil,
            title: nil
end
