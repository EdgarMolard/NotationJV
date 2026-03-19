--
-- PostgreSQL database dump
--

\restrict kwanaitSoHDAIsce8FYTWEaf92qi3ACypPZYGw0F2obNH0sQRSbWhCDfDtqbscY

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.jaime DROP CONSTRAINT IF EXISTS jaime_id_fkey;
ALTER TABLE IF EXISTS ONLY public.jaime DROP CONSTRAINT IF EXISTS jaime_id_avis_fkey;
ALTER TABLE IF EXISTS ONLY public.commente DROP CONSTRAINT IF EXISTS commente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.commente DROP CONSTRAINT IF EXISTS commente_id_avis_fkey;
ALTER TABLE IF EXISTS ONLY public.avis DROP CONSTRAINT IF EXISTS avis_id_fkey;
ALTER TABLE IF EXISTS ONLY public.utilisateur DROP CONSTRAINT IF EXISTS utilisateur_pkey;
ALTER TABLE IF EXISTS ONLY public.jaime DROP CONSTRAINT IF EXISTS jaime_pkey;
ALTER TABLE IF EXISTS ONLY public.commente DROP CONSTRAINT IF EXISTS commente_pkey;
ALTER TABLE IF EXISTS ONLY public.avis DROP CONSTRAINT IF EXISTS avis_pkey;
DROP TABLE IF EXISTS public.utilisateur;
DROP TABLE IF EXISTS public.jaime;
DROP TABLE IF EXISTS public.commente;
DROP TABLE IF EXISTS public.avis;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: avis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avis (
    id_avis uuid NOT NULL,
    stars numeric(2,1),
    nom_jeu character varying(50),
    nombre_heures integer,
    titre text,
    message text,
    date_creation date,
    id uuid NOT NULL
);


--
-- Name: commente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commente (
    id uuid NOT NULL,
    id_avis uuid NOT NULL,
    id_com uuid,
    message character varying(300),
    date_com timestamp without time zone
);


--
-- Name: jaime; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jaime (
    id uuid NOT NULL,
    id_avis uuid NOT NULL,
    date_like date
);


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utilisateur (
    id uuid NOT NULL,
    pseudo character varying(50),
    email character varying(50),
    password character varying(255),
    is_admin boolean
);


--
-- Data for Name: avis; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.avis (id_avis, stars, nom_jeu, nombre_heures, titre, message, date_creation, id) VALUES ('44fe8df5-aff0-4d2a-a29f-3589c491c9a8', 5.0, 'Elden Ring', 300, 'GAME OF ALL TIME ?', 'C''est trop amusant', '2026-03-19', 'c73aad4a-9c23-436a-9370-6e226a73644a');
INSERT INTO public.avis (id_avis, stars, nom_jeu, nombre_heures, titre, message, date_creation, id) VALUES ('1491e016-42df-4119-a0a9-7aa933984ee2', 3.0, 'Mass Effect', 5, 'Nul', 'nullos', '2026-03-19', 'c73aad4a-9c23-436a-9370-6e226a73644a');
INSERT INTO public.avis (id_avis, stars, nom_jeu, nombre_heures, titre, message, date_creation, id) VALUES ('5991e78c-8391-46b9-aec3-c1413cb156dd', 1.0, 'Rust', 1, 'CE JEU EST UNE DAUBE', 'J''arrête pas de mourir en boucle, c''est trop nul, il devrait y avoir un mode facile', '2026-03-19', '2a0423e0-3c8c-4854-860e-683dfd494bf7');


--
-- Data for Name: commente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.commente (id, id_avis, id_com, message, date_com) VALUES ('c73aad4a-9c23-436a-9370-6e226a73644a', '1491e016-42df-4119-a0a9-7aa933984ee2', 'a561ee8b-c01f-41dc-badb-5186529351b4', 'Tu as raison, c''est nullll', '2026-03-19 14:39:29.826212');
INSERT INTO public.commente (id, id_avis, id_com, message, date_com) VALUES ('2a0423e0-3c8c-4854-860e-683dfd494bf7', '44fe8df5-aff0-4d2a-a29f-3589c491c9a8', 'b66b9a9b-0d1c-41c4-a13a-8be0eb324314', 'Je suis bien d''accord, c''est top', '2026-03-19 15:38:05.442122');
INSERT INTO public.commente (id, id_avis, id_com, message, date_com) VALUES ('2a0423e0-3c8c-4854-860e-683dfd494bf7', '1491e016-42df-4119-a0a9-7aa933984ee2', '20dd6ff8-c629-4f4b-8004-45a376a2a3e4', 'Je ne trouve pas, c''est grave un jeu de OG, j''adore les jeux d''arcade et le cochon', '2026-03-19 15:42:03.036103');


--
-- Data for Name: jaime; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.jaime (id, id_avis, date_like) VALUES ('c73aad4a-9c23-436a-9370-6e226a73644a', '1491e016-42df-4119-a0a9-7aa933984ee2', '2026-03-19');
INSERT INTO public.jaime (id, id_avis, date_like) VALUES ('2a0423e0-3c8c-4854-860e-683dfd494bf7', '1491e016-42df-4119-a0a9-7aa933984ee2', '2026-03-19');
INSERT INTO public.jaime (id, id_avis, date_like) VALUES ('2a0423e0-3c8c-4854-860e-683dfd494bf7', '44fe8df5-aff0-4d2a-a29f-3589c491c9a8', '2026-03-19');


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.utilisateur (id, pseudo, email, password, is_admin) VALUES ('c73aad4a-9c23-436a-9370-6e226a73644a', 'Edgar', 'edgar.mlrd@gmail.com', '$2b$10$NDEyvwv6QPYsl.sh36BVseC1uSedyKqO79LJh6JvqT6eNO31gSMw6', false);
INSERT INTO public.utilisateur (id, pseudo, email, password, is_admin) VALUES ('2a0423e0-3c8c-4854-860e-683dfd494bf7', 'Adnane', 'toxiqozz@gmail.com', '$2b$10$KEcG8mgJhoP63k4G5Ytzs.ntyNxMMOBSFspXImhVzI7kFXOPXR4L.', false);


--
-- Name: avis avis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_pkey PRIMARY KEY (id_avis);


--
-- Name: commente commente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commente
    ADD CONSTRAINT commente_pkey PRIMARY KEY (id, id_avis);


--
-- Name: jaime jaime_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jaime
    ADD CONSTRAINT jaime_pkey PRIMARY KEY (id, id_avis);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- Name: avis avis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_id_fkey FOREIGN KEY (id) REFERENCES public.utilisateur(id);


--
-- Name: commente commente_id_avis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commente
    ADD CONSTRAINT commente_id_avis_fkey FOREIGN KEY (id_avis) REFERENCES public.avis(id_avis);


--
-- Name: commente commente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commente
    ADD CONSTRAINT commente_id_fkey FOREIGN KEY (id) REFERENCES public.utilisateur(id);


--
-- Name: jaime jaime_id_avis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jaime
    ADD CONSTRAINT jaime_id_avis_fkey FOREIGN KEY (id_avis) REFERENCES public.avis(id_avis);


--
-- Name: jaime jaime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jaime
    ADD CONSTRAINT jaime_id_fkey FOREIGN KEY (id) REFERENCES public.utilisateur(id);


--
-- PostgreSQL database dump complete
--

\unrestrict kwanaitSoHDAIsce8FYTWEaf92qi3ACypPZYGw0F2obNH0sQRSbWhCDfDtqbscY

