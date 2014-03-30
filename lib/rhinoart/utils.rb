# encoding: utf-8
module Rhinoart
    class Utils
        def self.to_slug(str)     
            # strip the string
            ret = str.strip

            #blow away apostrophes
            ret.gsub! /['`]/, ""

            # @ --> at, and & --> and
            ret.gsub! /\s*@\s*/, " at "
            ret.gsub! /\s*&\s*/, " and "

            # replace all non alphanumeric, periods with dash
            ret.gsub! /\s*[^A-Za-z0-9А-Яа-я\.\/]\s*/, '-'

            # replace underscore with dash
            ret.gsub! /[-_]{2,}/, '-'

            # convert double underscores to single
            ret.gsub! /-+/, "-"

            # strip off leading/trailing dash
            ret.gsub! /\A[-\.]+|[-\.]+\z/, ""

            Russian.translit(ret).downcase
        end
    end
end
