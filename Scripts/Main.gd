extends Node

export(float) var vitesse = 1.0

# Le graphe est décrit sous la forme de liste d'adjacence
# Chaque noeud est lié à la liste des neud avec lesquels il est connecté par une arête
# Les murs sont bien sûr exclus du graphe
var graphe = {
	1: [2],
	2: [1,3],
	3: [2,4,8],
	4: [3,5],
	5: [4,10],
	8: [3,13],
	10: [5,15],
	11: [16,12],
	12: [11,13],
	13: [12,8,14],
	14: [13,15],
	15: [14,10,20],
	16: [11,21],
	20: [15,25],
	21: [16,22],
	22: [21,23],
	23: [22,24],
	24: [23,25],
	25: [24,20]
}
# Le tableau parcours nous sert de file pour effectuer le parcours en largeur
var parcours = []
# Le tableau visite marque les noeuds au fur et à mesure qu'ils ont été visités
# si le numéro du noeud s'y retrouve, c'est qu'il a été visité
# On se servira de ce tableau pour l'animation finale du parcours de l'algorithme
var visite = []


# Algorithme du parcours en largeur
func parcours_largeur():
	# On commence par enfiler le premier noeud et le marquer comme visité
	parcours.push_front(graphe[1])
	visite.append(1)
	# Ensuite tant que notre file n'est pas vide :
	# - On défile un noeud
	# - Chaque voisin qui n'a pas été visité est marqué
	# - Ces voisins non visités sont ajoutés à la file
	while !parcours.empty():
		var noeud = parcours.pop_back()
		for voisin in noeud:
			if !visite.has(voisin):
				visite.append(voisin)
				parcours.push_front(graphe[voisin])
	# Le Timer est démarré pour afficher l'animation un fois que l'algorithme a fini son travail
	$Timer.start(vitesse)


# Algorithme de parcours en profondeur
func parcours_profondeur():
	# On commence par envoyer la fonction récursive visiteur sur la racine
	visiteur(1)
	$Timer.start(vitesse)

func visiteur(noeud):
	# On commence par marquer le noeud que l'on visite
	visite.append(noeud)
	# On creuse le chemin à partir de chaque voisin
	# Tand que l'on aura pas atteint une impasse, le for attendra pour lancer une autre direction
	for voisin in graphe[noeud]:
		if !visite.has(voisin):
				visiteur(voisin)

# Fonctions utilitaires pour l'affichage et le GUI
func _on_Timer_timeout():
	if !visite.empty():
		var index = visite.pop_front()
		var case = get_node("Noeud" + str(index))
		case._visite()
	else:
		#_reset()
		$Timer.stop()
		
func _reset():
	get_tree().call_group("Cases", "_reset_color")


func _on_Boutonlargeur_pressed():
	parcours_largeur()


func _on_BoutonReset_pressed():
	_reset()


func _on_BoutonProfondeur_pressed():
	parcours_profondeur()
