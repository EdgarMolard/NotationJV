import { Link } from "react-router-dom";

export default function InscriptionPage() {
  const onSubmit = (event) => {
    event.preventDefault();
  };

  return (
    <main className="auth-page">
      <section className="auth-panel">
        <p className="kicker">NotationJV</p>
        <h1>Inscription</h1>
        <p className="subtitle">Crée un compte puis accéde à ton espace.</p>

        <form className="auth-form" onSubmit={onSubmit}>
          <label htmlFor="username">Nom d'utilisateur</label>
          <input id="username" name="username" type="text" placeholder="JohnDoe" required />

          <label htmlFor="email">Adresse e-mail</label>
          <input id="email" name="email" type="email" placeholder="prenom.nom@exemple.com" required />

          <label htmlFor="password">Mot de passe</label>
          <input id="password" name="password" type="password" placeholder="********" required />

          <label htmlFor="confirmPassword">Confirmer le mot de passe</label>
          <input id="confirmPassword" name="confirmPassword" type="password" placeholder="********" required />

          <button type="submit">S'inscrire</button>
        </form>

        <p className="helper">
          Deja un compte ? <Link className="auth-link" to="/connexion">Se connecter</Link>
        </p>

      </section>
    </main>
  );
}