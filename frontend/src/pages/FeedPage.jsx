import { useMemo, useState, useEffect, useCallback, useRef } from "react";
import { Link, useNavigate } from "react-router-dom";
import { logout } from "../services/ConnexionService";
import { fetchAvis } from "../services/AvisService";
import ReviewCard from "../components/ReviewCard";
import "../styles/FeedPage.css";

export default function FeedPage() {
	const [isMenuOpen, setIsMenuOpen] = useState(false);
	const [actionError, setActionError] = useState("");
	const navigate = useNavigate();
	const username = useMemo(() => localStorage.getItem("username") ?? "", []);
	const isConnected = username.length > 0;

	// États pour les avis
	const [reviews, setReviews] = useState([]);
	const [page, setPage] = useState(1);
	const [loading, setLoading] = useState(false);
	const [hasMore, setHasMore] = useState(true);
	const [error, setError] = useState("");
	const observerTarget = useRef(null);

	// Charger les avis
	const loadMore = useCallback(async () => {
		if (loading) return;
		setLoading(true);
		setError("");
		try {
			const response = await fetchAvis(page, 10);
			setReviews((prev) => [...prev, ...response.data]);
			setHasMore(page < response.pagination.pages);
			setPage((prev) => prev + 1);
		} catch (err) {
			// On bloque l'auto-chargement pour eviter une boucle de requetes si l'API est en erreur.
			setHasMore(false);
			setError(err instanceof Error ? err.message : "Erreur lors du chargement des avis");
		} finally {
			setLoading(false);
		}
	}, [page, loading]);

	// Premier chargement
	useEffect(() => {
		loadMore();
	}, []);

	// Infinite scroll avec Intersection Observer
	useEffect(() => {
		const observer = new IntersectionObserver(
			(entries) => {
				if (entries[0].isIntersecting && hasMore && !loading) {
					loadMore();
				}
			},
			{ threshold: 0.1 }
		);

		if (observerTarget.current) {
			observer.observe(observerTarget.current);
		}

		return () => {
			if (observerTarget.current) {
				observer.unobserve(observerTarget.current);
			}
		};
	}, [loadMore, hasMore, loading]);

	const handleLogout = async () => {
		try {
			await logout();
			setIsMenuOpen(false);
			navigate("/connexion");
		} catch (err) {
			const message = err instanceof Error ? err.message : "Erreur lors de la deconnexion.";
			setActionError(message);
		}
	};

	const handleCommentSuccess = () => {
		// Recharger les avis pour afficher le nouveau commentaire
		setHasMore(true);
		setPage(1);
		setReviews([]);
		loadMore();
	};

	const handleRetry = () => {
		// Re-active le chargement manuel apres une erreur reseau/API.
		setHasMore(true);
		loadMore();
	};

	return (
		<main className="feed-page">
			<section className="feed-panel">
				<div className="feed-topbar">
					{isConnected ? (
						<div className="user-menu">
							<button
								type="button"
								className="user-trigger"
								onClick={() => setIsMenuOpen((prev) => !prev)}
							>
								{username}
							</button>
							{isMenuOpen && (
								<div className="user-dropdown">
									<button type="button" className="menu-item" disabled>
										Mon Profil (bientot)
									</button>
									<button type="button" className="menu-item menu-item-danger" onClick={handleLogout}>
										Se deconnecter
									</button>
								</div>
							)}
						</div>
					) : (
						<div className="hub-actions">
							<Link className="hub-link" to="/connexion">Connexion</Link>
							<Link className="hub-link" to="/inscription">Inscription</Link>
						</div>
					)}
				</div>

				<div className="feed-header">
					<h1>Fil d'actualité</h1>
					<p>Découvrez les avis des joueurs</p>
				</div>

				{actionError && <p className="auth-errors">{actionError}</p>}

				<div className="reviews-container">
					{reviews.length === 0 && !loading && (
						<div className="empty-state">
							<p>Aucun avis pour le moment. Soyez le premier à en laisser un ! 🎮</p>
						</div>
					)}

					{reviews.map((review) => (
						<ReviewCard
							key={review.id}
							review={review}
							isConnected={isConnected}
							onCommentSuccess={handleCommentSuccess}
						/>
					))}

					{loading && (
						<div className="loading-state">
							<div className="spinner"></div>
							<p>Chargement des avis...</p>
						</div>
					)}

					{error && (
						<div className="error-state">
							<p>⚠️ {error}</p>
							<button onClick={handleRetry} className="retry-btn">
								Réessayer
							</button>
						</div>
					)}

					{!hasMore && reviews.length > 0 && (
						<div className="end-of-list">
							<p>Vous avez tout vu ! 🎉</p>
						</div>
					)}

					<div ref={observerTarget} className="observer-target" />
				</div>
			</section>
		</main>
	);
}
