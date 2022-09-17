import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rcParams
rcParams['figure.figsize'] = (12, 7)
rcParams['axes.spines.top'] = False
rcParams['axes.spines.right'] = False
import seaborn as sns
from sklearn.model_selection import train_test_split
import sklearn.metrics as sk_metrics

class RegresionLineal:
    '''La clase con la que se implementara el modelo de regresión'''

    '''Iniciamos con atributos de la ecuación lineal, el intercepto (b0) y la pendiente (b1)'''
    def __init__(self): 
        self.b0 = None
        self.b1 = None
    
    def fit(self, X, y):
        '''
        Aqui entrenaremos el modelo y ajustaremos la ecuación a los datos que proporcionemos. 
        Los coeficientes se calculan con base a ecuaciones ya conocidas.
        
        :X: array, variable unica
        :y: array, valores reales
        '''
        self.b1 = (np.sum((X - np.mean(X)) * (y - np.mean(y)))) / (np.sum((X - np.mean(X)) ** 2))
        self.b0 = np.mean(y) - self.b1 * np.mean(X)
        
    def predict(self, X):
        '''
        Aqui se realizaran las predicciones, dado un punto especifico o un array, utilizando ya los valores que obtuvimos en fit()
    
        :X: array, variable unica
        '''

        if not self.b0 or not self.b1:
            raise Exception('`SimpleLinearRegression.fit(X, y)` no ha sido llamada.')
        return self.b0 + self.b1 * X


print()
print("Regresión Lineal simple")
print("-------------------------")
print("Generando y procesando datos iniciales...")

X = np.arange(start=1, stop=301)
y = np.random.normal(loc=X, scale=20)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0)

print("Entrenando modelo de regresión...")
linear_model = RegresionLineal()
linear_model.fit(X_train,y_train)
y_pred = linear_model.predict(X_test)

print("Obteniendo resultados...")
print("RMSE: \n",np.sqrt(sk_metrics.mean_squared_error(y_test, y_pred)))
print("Coeficientes obtenidos:")
b0 = "{:.2f}".format(linear_model.b0)
b1 = "{:.2f}".format(linear_model.b1)

print("B0 = "+str(b0) + " B1 = "+str(b1))

plt.figure()
plt.scatter(X, y, s=200, c='#087E8B', alpha=0.65, label='Puntos originales generados')
plt.scatter(X_test, y_pred, color='#000000', label='Puntos predichos por el modelo') #lw=3, label=f'Best fit line > B0 = {model_all.b0:.2f}, B1 = {model_all.b1:.2f}')
plt.title('Resultado del modelo implementado con libreria', size=20)
plt.xlabel('X', size=14)
plt.ylabel('Y', size=14)
plt.legend()
plt.show()