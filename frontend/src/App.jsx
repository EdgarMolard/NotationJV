import { Navigate, Route, Routes } from "react-router-dom";
import ConnexionPage from "./pages/ConnexionPage";
import InscriptionPage from "./pages/InscriptionPage";

export default function App() {
  return (
    <Routes>
      <Route path="/connexion" element={<ConnexionPage />} />
      <Route path="/inscription" element={<InscriptionPage />} />
      <Route path="/" element={<Navigate to="/connexion" replace />} />
      <Route path="*" element={<Navigate to="/connexion" replace />} />
    </Routes>
  );
}
