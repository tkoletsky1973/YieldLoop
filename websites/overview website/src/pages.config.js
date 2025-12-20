import Home from './pages/Home';
import Architecture from './pages/Architecture';
import About from './pages/About';
import Simulator from './pages/Simulator';
import __Layout from './Layout.jsx';


export const PAGES = {
    "Home": Home,
    "Architecture": Architecture,
    "About": About,
    "Simulator": Simulator,
}

export const pagesConfig = {
    mainPage: "Home",
    Pages: PAGES,
    Layout: __Layout,
};