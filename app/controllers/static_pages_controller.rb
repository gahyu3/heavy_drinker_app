# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top privacy]

  def top; end

  def privacy; end

  def rule; end
end
