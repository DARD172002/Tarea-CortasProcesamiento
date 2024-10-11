"""En la lecci´on del 24 de setiembre del 2024, se explic´o la aplicaci´on del efecto croma en im´agenes.
Implementar en Python, el efecto croma estudiado en clase, basado en el c´odigo generado en GNU
Octave. Para eso, utilice las im´agenes fondo verde.jpg y playa.jpg, que se encuentran en la
carpeta de One Drive de dicha lecci´on"""

import cv2 as cv
from matplotlib import pyplot as pl
import numpy as np

def fondo_verde(A,B):
    #Asegurarse de que ambas imagenes son iguales
   if(A.shape!=B.shape):
      raise("las imagenes A y B deben de tener el mismo tamaño")
   
    # Crear imágenes vacías para los resultados intermedios
   C1 = np.zeros_like(A, dtype=np.uint8)  # Imagen A con fondo negro en lugar de verde
   C2 = np.zeros_like(A, dtype=np.uint8)  # Imagen B con negro en los píxeles de la imagen que no es verde de A

      # Definir máscara para detectar el verde (ajustar tolerancia si es necesario)
   mask1 = (A[:, :, 0] < 100) & (A[:, :, 1] >= 125) & (A[:, :, 2] < 100)
   mask2 = np.logical_not(mask1)
   # Obtener persona de la imagen A, con fondo negro
   C1[:, :, 0] = mask2 * A[:, :, 0]
   C1[:, :, 1] = mask2 * A[:, :, 1]
   C1[:, :, 2] = mask2 * A[:, :, 2]

   # Obtener fondo de la imagen B, pero negro en la posición de la persona en A
   C2[:, :, 0] = mask1 * B[:, :, 0]
   C2[:, :, 1] = mask1 * B[:, :, 1]
   C2[:, :, 2] = mask1 * B[:, :, 2]

    # Combinar las dos imágenes
   C = C1 + C2

   return C

A=cv.imread("imagenes/fondo_verde.jpg")
B=cv.imread("imagenes/playa.jpg")

C=fondo_verde(A,B)

pl.subplot(2,2,1)
pl.imshow(A)




pl.subplot(2,2,2)
pl.imshow(B)





pl.subplot(2,2,3)
pl.imshow(C)

pl.tight_layout()
pl.show()