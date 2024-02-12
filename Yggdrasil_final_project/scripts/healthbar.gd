extends TextureProgress

# Définir la valeur de la santé maximale
var max_health = 100

# Fonction pour mettre à jour la barre de vie
func update_health(health):
	# Limiter la valeur de la santé entre 0 et max_health
	health = clamp(health, 0, max_health)
	# Mettre à jour la valeur de la barre de vie
	value = health


# Exemple d'utilisation :
# Appeler cette fonction avec la valeur de santé actuelle
# update_health(50) # Mettra à jour la barre de vie à 50%
