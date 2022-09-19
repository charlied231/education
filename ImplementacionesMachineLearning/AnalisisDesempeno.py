import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rcParams
rcParams['figure.figsize'] = (12, 7)
rcParams['axes.spines.top'] = False
rcParams['axes.spines.right'] = False
import seaborn as sns
from mlxtend.evaluate import bias_variance_decomp
from sklearn.model_selection import train_test_split
from sklearn import tree
from sklearn.ensemble import RandomForestRegressor
from sklearn.pipeline import make_pipeline
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler, MinMaxScaler
import sklearn.metrics as sk_metrics

print()
print("desempeño del modelo (Random Forest Regressor - sklearn)")
print("-------------------------")
print("Generando y procesando datos iniciales...")

X = np.arange(start=1, stop=301)
y = np.random.normal(loc=X, scale=20)
X = X.reshape(-1, 1)


scaler = preprocessing.MinMaxScaler().fit(X)
X = scaler.transform(X)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0)
#X_test, X_validation, y_test, y_validation = train_test_split(X_test, y_test, test_size=0.5, random_state=0)

print("Entrenando modelo de regresión...")
random_model = RandomForestRegressor(n_estimators = 150, max_depth = 6, min_samples_split = 5).fit(X_train,y_train)
y_pred = random_model.predict(X_test)

print("Obteniendo resultados...")
mse, bias, var = bias_variance_decomp(random_model, X_train, y_train, X_test, y_test, loss='mse', num_rounds=200, random_seed=0)

print('MSE from bias_variance lib [avg expected loss]: %.3f' % mse)
print('Avg Bias: %.3f' % np.sqrt(bias))
print('Avg Variance: %.3f' % var)
print('Root Mean Square error by Sckit-learn lib: %.3f' % np.sqrt(sk_metrics.mean_squared_error(y_test,y_pred)))

plt.figure()
plt.scatter(X[:,0], y, s=200, c='#087E8B', alpha=0.65, label='Puntos originales generados')
plt.scatter(X_test[:,0], y_pred, color='#000000', label='Puntos predichos por el modelo') #lw=3, label=f'Best fit line > B0 = {model_all.b0:.2f}, B1 = {model_all.b1:.2f}')
plt.title('Resultado del modelo implementado con libreria', size=20)
plt.xlabel('X', size=14)
plt.ylabel('Y', size=14)
plt.legend()
plt.show()

print("Luego de ver los resultados que obtuvimos, podemos ver que en nuestro caso el sesgo es considereablemente menor a la varianza asi que el modelo tiende a  sobre ajustar como lo podemos ver en la grafica.")
print("Tambien podemos ver que se presenta una varianza alta, pues los residuos y los puntos van cambiando constantemente.")
print("Por ultimo, nuestra conclusión es que el modelo presenta una varianza mayor al sesgo, por lo que el overfit es visible al ver como los puntos no siguen la distribución como recta y se van por el lado de la variación que fuimos introduciendo en el ejercicio")
