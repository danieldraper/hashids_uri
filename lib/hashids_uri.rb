require 'hashids'
require 'active_record'

module ActiveRecord
  module HashidsUri
    def self.included(base)
      base.extend         ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      def has_hashids_uri(options = {})
        class_attribute :salt, :min_length

        self.salt = options.fetch(:salt, '')
        self.min_length = options.fetch(:min_length, 6)
      end

      def find_by_hash(hash)
        decoded_id = ::Hashids.new(
          self.salt,
          self.min_length
        ).decode(hash).first

        find(decoded_id)
      end

      def find(*args)
        id = args.first
        return super if args.count != 1 || (Integer(id) rescue false)
        find_by_hash(id).tap { |result| return result unless result.nil? }
        raise ActiveRecord::RecordNotFound, "cannot find record with hash id: #{id.inspect}"
      end
    end

    module InstanceMethods
      def salt
        self.class.salt
      end

      def min_length
        self.class.min_length
      end

      def hashid
        ::Hashids.new(
          salt,
          min_length
        ).encode(id)
      end

      def to_param
        hashid
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::HashidsUri)
