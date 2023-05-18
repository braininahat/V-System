import numpy as np
from vispy import app, scene

# Generate random data with shape (512, 512, 140)
data = np.random.random((512, 512, 140))

# Reshape the data to create a (x, y, z) coordinate array
x, y, z = np.indices(data.shape)

# Flatten the coordinate arrays and data
x = x.flatten()
y = y.flatten()
z = z.flatten()
data = data.flatten()

canvas = scene.SceneCanvas(keys="interactive", bgcolor="white")
view = canvas.central_widget.add_view()

scatter = scene.visuals.Markers()
scatter.set_data(np.column_stack((x, y, z)), edge_color="k", face_color=data, size=1)

view.add(scatter)

axis = scene.visuals.XYZAxis(parent=view.scene)

canvas.show()
app.run()
