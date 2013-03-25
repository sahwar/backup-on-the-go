#!/usr/bin/env ruby

require 'backup_on_the_go'

if ARGV.length == 0
  puts <<END
  Usage:

  backup-on-the-go key0:string_value0 key1:string_value1 key2?boolean_value2 ...

  e.g.
  backup-on-the-go user:username is_prviate?false

  For the description of keys and values, please see the document of
  BackupOnTheGo.backup

END
  exit
end

config = Hash.new

ARGV.each do |a|

  # string value
  key, value = a.split(':', 2)
  if value != nil
    config[key.to_sym] = value
    next
  end

  # boolean value
  key, value = a.split('?', 2)
  if value != nil
    value.strip!

    if value == 'true' or value == 'yes' or value == '1'
      config[key.to_sym] = true
    elsif value == 'false' or value == 'no' or value == '0'
      config[key.to_sym] = false
    end
  end
end

BackupOnTheGo.backup config
