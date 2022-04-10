defmodule HomeworkTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  use HTTPoison.Base
  # Start hound session and destroy when tests are run
  hound_session()

  #Write function to replace $ sign and convert to float and return value. To be used with sort table example
  def stringreplace(value) do

    value_return = String.replace(value,"$","")
    value_return = String.to_float(value_return)
    value_return
  end

  ######### Example 1(Plus one more in terms of API call): Form Validation Tests - Get User name from API and pass it to form #################################################
  #@tag :skip
  test "error on invalid username" do
    # Get the root directory and append screenshot folder path to pass to function
    wd = File.cwd!
    screenshot_path = Enum.join([wd, "/Screenshot/Username_Error.png"],"")
    # Use API from https://reqres.in to get username to be passed in the form
    resp = HTTPoison.get!(Application.get_env(:hound, :login_form_user_api))
    resp_body = resp.body
    #Decode the response and get the user name from the map and key
    json = Poison.decode!(resp_body)
    username = json["data"]["first_name"]
    IO.inspect json["data"]["first_name"], label: "The user name being passed is"
    flashelement_text = formvalidation(username,"test123",screenshot_path)
    #flashelement_text = formvalidation("vipin","test123",screenshot_path)
    assert flashelement_text =~ "Your username is invalid!"
    assert current_url()

  end
  #@tag :skip
  test "error on invalid password" do
    wd = File.cwd!
    screenshot_path = Enum.join([wd, "/Screenshot/Password_Error.png"],"")
    flashelement_text = formvalidation(Application.get_env(:hound, :valid_username),"test123",screenshot_path)
    assert flashelement_text =~ "Your password is invalid!"
    assert current_url()

  end

  #@tag :skip
  test "On Valid credentials" do
    wd = File.cwd!
    screenshot_path = Enum.join([wd, "/Screenshot/Successful_Login.png"],"")
    flashelement_text = formvalidation(Application.get_env(:hound, :valid_username),Application.get_env(:hound, :valid_pwd),screenshot_path)
    assert flashelement_text =~ "You logged into a secure area!"
    assert current_url()

  end
  ######### Example 2: Sort table Validation Tests #################################################
  #@tag :skip
  test "sort table in ascending order when no class or attribute present" do

    navigate_to(Application.get_env(:hound, :sorttable_url))
    #Call functions to find element, click on them and get the amount list from column
    #due_amount = find_element(:css, "#table1 thead tr th:nth-of-type(4)")
    due_amount = find_element(:css, Application.get_env(:hound, :due_amount))
    clickonelement(due_amount)
    Process.sleep(5000)
    listactual = navigateandgetvalues()
    list_exp = Enum.sort(listactual)
    IO.inspect listactual, label: "The actual list is"
    IO.inspect list_exp, label: "The exp list is"
    if  assert listactual==list_exp do
      IO.puts "Sorting in ascending passed!"
    end
  end
  #@tag :skip
  test "sort table in descending order" do
    #navigate_to("https://the-internet.herokuapp.com/tables")
    navigate_to(Application.get_env(:hound, :sorttable_url))
    #Order the amount column by clicking on the column name
    due_amount = find_element(:css, "#table1 thead tr th:nth-of-type(4)")
    clickonelement(due_amount)
    clickonelement(due_amount)
    listactual = navigateandgetvalues()
    list_exp = Enum.sort(listactual)
    list_exp = Enum.reverse(list_exp)
    IO.inspect listactual, label: "The actual list is"
    IO.inspect list_exp, label: "The exp list is"
    if  assert listactual==list_exp do
      IO.puts "Sorting in descending passed!"
    end

  end
  ######### Example 3: Iframe identification, add text and take screenshot validation Tests #################################################
  #@tag :skip
  test "identify iframe and manage elements" do
    navigate_to(Application.get_env(:hound, :iframe_url))
    iframe = find_element(:id, Application.get_env(:hound, :iframe_id))
    focus_frame(iframe)
    find_element(:xpath, Application.get_env(:hound, :iframe_body)) |> fill_field(Application.get_env(:hound, :iframe_text))
    wd = File.cwd!
    screenshot_path = Enum.join([wd, "/Screenshot/Fill_text_iframe_success.png"],"")
    take_screenshot(screenshot_path)

  end


  # Simple fn to click on element
  defp  clickonelement(element) do
    element |> click()
  end


  # Find and get values to a list. to be used with sort table example
  defp navigateandgetvalues do

    first_value =  stringreplace(visible_text(find_element(:xpath, Application.get_env(:hound, :table_value1))))
    second_value = stringreplace(visible_text(find_element(:xpath, Application.get_env(:hound, :table_value2))))
    third_value = stringreplace(visible_text(find_element(:xpath, Application.get_env(:hound, :table_value3))))
    fourth_value = stringreplace(visible_text(find_element(:xpath, Application.get_env(:hound, :table_value4))))
    #Store results in a list and sort the list using built in function. Compare the sorted list to origninal list to see if it sorted
    list_actual = [first_value, second_value,third_value, fourth_value ]
    list_actual

  end
  # Write function to that returns text as well as saves screenshots for different input conditions
  # Get userid, pwd, fill the elements, clickbutton and return message. To be used with form validation example
  defp formvalidation(user,pwd,screenshot_path) do
    #navigate_to("https://the-internet.herokuapp.com/login")
    IO.puts (Application.get_env(:hound, :login_url))
    navigate_to(Application.get_env(:hound, :login_url))
    #navigate_to(logintesturl)

    username = find_element(:id, "username")
    password = find_element(:id, "password")
    loginbutton = find_element(:class, "radius")
    username |> fill_field(user)
    password |> fill_field(pwd)
    loginbutton |> click()
    take_screenshot(screenshot_path)
    #take_screenshot()
    flashelement = find_element(:css, "#flash")
    flashelement_text = visible_text(flashelement)
    IO.puts flashelement_text
    flashelement_text

  end


end
