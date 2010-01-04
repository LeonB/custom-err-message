module ActiveRecord
  class Errors

    # Redefine the ActiveRecord::Errors::full_messages method:
    #  Returns all the full error messages in an array. 'Base' messages are handled as usual.
    #  Non-base messages are prefixed with the attribute name as usual UNLESS they begin with '^'
    #  in which case the attribute name is omitted.
    #  E.g. validates_acceptance_of :accepted_terms, :message => '^Please accept the terms of service'
    def full_messages
      full_messages = []

      @errors.each do |attr, error|
        @errors[attr].each do |error|
          next if error.message.nil?

          if attr == "base"
            full_messages << error.message
          elsif error.message =~ /^\^/
            full_messages << error.message[1..-1]
          else
            full_messages << @base.class.human_attribute_name(attr) + " " + error.message
          end
        end
      end

      return full_messages
    end
  end
end

