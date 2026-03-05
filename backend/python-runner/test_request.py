import urllib.request, json
req = urllib.request.Request('http://localhost:8000/execute', 
                             data=json.dumps({'code': 'import numpy as np\narr0 = np.array(42)\nprint(arr0.ndim)'}).encode('utf-8'), 
                             headers={'Content-Type': 'application/json'})
res = urllib.request.urlopen(req)
print(res.read().decode('utf-8'))
