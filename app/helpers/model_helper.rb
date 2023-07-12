# frozen_string_literal: true

module ModelHelper
  def han(model, attribute)
    model.to_s.classify.constantize.human_attribute_name(attribute)
  end

  def model_states(model, state_machine = :default)
    model.to_s.classify.constantize.aasm(state_machine).states
  end

  def states_for_select(model, state_machine = :default)
    model_states(model, state_machine).map { |state| [state.human_name, state.name] }
  end
end
