import numpy
import matplotlib.pyplot as plt 
import cv2 as cv
img=cv.imread('./imagenes/columnas.jpg')
print(img)
plt.subplot(1,1,1)
plt.imshow(img)

plt.show()