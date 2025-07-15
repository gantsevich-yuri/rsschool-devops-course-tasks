from main.py import app

def test_root_route():
    client = app.test_client()
    response = client.get('/')
    assert response.status_code == 200
    assert response.data == b'Hello from RS DevOps course!'