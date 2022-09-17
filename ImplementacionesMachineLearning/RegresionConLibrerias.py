import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rcParams
rcParams['figure.figsize'] = (12, 7)
rcParams['axes.spines.top'] = False
rcParams['axes.spines.right'] = False
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn import tree
from sklearn.ensemble import RandomForestRegressor
from sklearn.pipeline import make_pipeline
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler, MinMaxScaler
import sklearn.metrics as sk_metrics

print()
print("Regresión con Random Forest Regressor (sklearn)")
print("-------------------------")
print("Generando y procesando datos iniciales...")

X = np.arange(start=1, stop=301)
y = np.random.normal(loc=X, scale=20)
X = X.reshape(-1, 1)


scaler = preprocessing.MinMaxScaler().fit(X)
X = scaler.transform(X)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0)

print("Entrenando modelo de regresión...")
random_model = RandomForestRegressor(n_estimators = 150, max_depth = 6, min_samples_split = 5).fit(X_train,y_train)
y_pred = random_model.predict(X_test)

print("Obteniendo resultados...")
print("RMSE: \n",np.sqrt(sk_metrics.mean_squared_error(y_test, y_pred)))

plt.figure()
plt.scatter(X[:,0], y, s=200, c='#087E8B', alpha=0.65, label='Puntos originales generados')
plt.scatter(X_test[:,0], y_pred, color='#000000', label='Puntos predichos por el modelo') #lw=3, label=f'Best fit line > B0 = {model_all.b0:.2f}, B1 = {model_all.b1:.2f}')
plt.title('Resultado del modelo implementado con libreria', size=20)
plt.xlabel('X', size=14)
plt.ylabel('Y', size=14)
plt.legend()
plt.show()