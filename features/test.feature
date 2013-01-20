#START:new_task
Feature: We can add new tasks
  As a busy developer with a lot of things to do
  I want to keep a list of tasks I need to work on

#END:new_task
  Background:
    Given my terminal size is "80x24"
    And my home directory is in "/tmp"
    And an empty tasklist in "/tmp/todo.txt"

#START:new_task
Scenario: Add a new task
  Given the file "/tmp/todo.txt" doesn't exist
  When I successfully run `todo -f /tmp/todo.txt new 'Some new task'`
  Then I successfully run `todo -f /tmp/todo.txt list`
  And the stdout should contain "Some new task"
#END:new_task

#START:home_dir
  Scenario: The task list is in our home directory by default
    Given there is no task list in my home directory
    When I successfully run `todo new 'Some new todo item'`
    Then the task list should exist in my home directory
    When I successfully run `todo list`
    Then the stdout should contain "Some new todo item"
#END:home_dir
