module TasksHelper
  def link_to_complete(task)
    link_to('&#x2714;', complete_task_path(task), :confirm => "Complete task '#{task.name}'?")
  end
end
