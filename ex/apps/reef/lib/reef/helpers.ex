defmodule Reef.Helpers do

  import Enum, only: [join: 2]

  def url do Reef.Endpoint.url() end
  def link url do join [url(), url], "/" end

end