# do I need to require sqlite3 with bundler?
require 'sqlite3'
require 'bundler'
Bundler.require

require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}
