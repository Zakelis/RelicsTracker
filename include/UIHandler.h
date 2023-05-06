#pragma once

#ifndef UIHANDLER_H
#define UIHANDLER_H

#include "Enums.h"
#include "ComputationHandler.h"
#include <SFML/Graphics.hpp>
#include <thread>

// Handles data display and ressources loading
class UIHandler
{
public:
	UIHandler();
	~UIHandler() = default;

	void display();
	void updateLoadingScreen(const int percentage);

private:
	// Basic operations
	void processInput(const sf::Event& event);
	void syncDataStructureToSFML();
	void loadCommonRessources();
	void drawCommonElements();
	void drawScreenElements();

	// Main screen
	void loadMainScreenRessources();
	void processMainScreenInput(const sf::Event& event);
	void computePlatInputPosition();
	void drawMainScreenElements();

	// Loading screen
	void loadLoadingScreenRessources();
	void processLoadingScreenInput(const sf::Event& event);
	void computeProgress();
	void drawLoadingScreenElements();

	// Result screen
	void loadResultsScreenRessources();
	void processResultsScreenInput(const sf::Event& event);
	bool changeActiveRelicCategory(sf::Text& _categoryTitle, const int mouseX, const int mouseY);
	void computeRelicsTextPositions(const std::map<std::string, std::map<std::string, double>>& relicsMap,
		std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap);
	void resetRelicsTextDefaultPositions(std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap);
	void scrollRelicsText(std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap,
		const float delta);
	void drawResultsScreenElements(const int mouseX, const int mouseY);
	void displayRelicsMap(std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap,
		const int mouseX, const int mouseY);

	// Debug
	void displayDebugHeader();

	// Computation handler
	ComputationHandler _computationHandler;
	std::thread _computationThread;
	double _WAThreshold{ 35 };

	// Window
	sf::RenderWindow _window;
	std::string	_windowTitle{"RelicsTracker v.1.3"};
	WindowScreenType _screenType;
	unsigned int _windowWidth{ 1920 };
	unsigned int _windowHeight{ 1080 };

	// Common ressources
	sf::Texture _backgroundTexture;
	sf::Sprite _backgroundSprite;
	sf::Font _textFont;
	sf::Text _helpText;
	sf::Texture _platTexture;

	// Main screen
	sf::Text _mainScreenTitle;
	sf::Text _platPrompt;
	std::string _platInput;
	sf::Text _platTextInput;

	// Loading screen
	sf::Text _loadingScreenTitle;
	sf::Text _percentageText;
	sf::Sprite _progressSprite;
	unsigned int _maxProgressShapeLength{ 1500 };

	// Results screen
	std::vector<std::pair<sf::Text, std::vector<sf::Text>>> _lithText;
	std::vector<std::pair<sf::Text, std::vector<sf::Text>>> _mesoText;
	std::vector<std::pair<sf::Text, std::vector<sf::Text>>> _neoText;
	std::vector<std::pair<sf::Text, std::vector<sf::Text>>> _axiText;
	sf::Text _relicPlaceholderText;

	sf::Text _lithTitle;
	sf::Text _mesoTitle;
	sf::Text _neoTitle;
	sf::Text _axiTitle;

	sf::RectangleShape _separatorBetweenRelicsAndRelicsTypes;
	sf::RectangleShape _separatorBetweenRelicsAndItems;
	sf::Sprite _platSprite;

	ActiveRelicCategory _activeRelicCategory;
};

#endif //UIHANDLER_H