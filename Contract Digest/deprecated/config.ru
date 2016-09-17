#!/usr/bin/env rackup -s thin -p 3060
# encoding: utf-8

# === Usage === #
# Can be run using ./config.ru

# === Environment === #
require File.expand_path("../bin/init.rb", __FILE__)

# === Sinatra === #
require "sinatra"

table = DB.collection("users")

# Create user, send confirmation email & register cron tasks.
post "/users" do
  email = params[:user][:email]

  if table.find_one(email: email)
    table.update({email: email}, params[:user])
    "Your settings have been updated."
  else
    table.insert(params[:user])
    send_confirmation_email(email)
    "You have been subscribed."
  end
end

# Delete user.
# Yeah, you can usubscribe anyone you like. Just don't do it dude, alright?
delete "/users/:email" do
  table.remove(email: params[:email])

  send_usubscription_email(params[:email])
end

# === E-mails === #
require "pony"

# Pony.options = {via: :smtp, via_options: {host: "smtp.gmail.com"}}

# http://berlinstartupjobs.com/
# https://geekli.st/jobs
# http://thechangelog.com/jobs/
helpers do
  def mail(to, subject, body)
    Pony.mail(to: to, from: "james@101ideas.cz", subject: subject, body: body)
  end

  def send_confirmation_email(receiver)
    mail(receiver, "You have been subscribed to contract-digest", "Just sayin'")
  end

  def send_usubscription_email(receiver)
    mail(receiver, "You have been unsubscribed from contract-digest", "Heartbreaker! Subscribe back? http://contract-digest.com")
  end
end

# === Assets === #
# Make sure they won't get served through Rack in production.
unless ENV["RACK_ENV"] == "production"
  use Rack::Static, urls: ["/assets"]

  # TODO: Nginx rewrite.
  get "/" do
    ::File.open("assets/index.html")
  end
end

run Sinatra::Application
