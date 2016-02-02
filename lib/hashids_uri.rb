require 'hashids'
require 'active_record'

module ActiveRecord
  module HashidsUri
    extend ::ActiveSupport::Concern

    class << self
      attr_accessor :salt, :min_length
    end

    module ClassMethods
      def has_hashids_uri(options = {})
        ActiveRecord::HashidsUri.salt       = options.fetch(:salt, '')
        ActiveRecord::HashidsUri.min_length = options.fetch(:min_length, 6)

        include InstanceMethods
      end
    end

    module ClassMethods
      def find_by_hash(hash)
        find(
          ::Hashids.new(
            ActiveRecord::HashidsUri.salt,
            ActiveRecord::HashidsUri.min_length,
          ).decode(hash).first
        )
      end

      def find(*args)
        id = args.first
        return super if args.count != 1 || (Integer(id) rescue false)
        find_by_hash(id).tap { |result| return result unless result.nil? }
        raise ActiveRecord::RecordNotFound, "cannot find record with hash id: #{id.inspect}"
      end
    end

    module InstanceMethods
      def to_param
        ::Hashids.new(
          ActiveRecord::HashidsUri.salt,
          ActiveRecord::HashidsUri.min_length
        ).encode(id)
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::HashidsUri)
