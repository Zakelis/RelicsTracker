#include "UIHandler.h"
#include <iostream>
#include <sstream>

// Setup window properties and load the ressources at start to avoid performances issues later
UIHandler::UIHandler()
{
	_window.create(sf::VideoMode(_windowWidth, _windowHeight), _windowTitle, sf::Style::Fullscreen);
	_window.setVerticalSyncEnabled(true);

    sf::Image icon;
    if (icon.loadFromFile("./../../../ressources/Images/Plat.png"))
    {
        _window.setIcon(icon.getSize().x, icon.getSize().y, icon.getPixelsPtr());
    }

	_screenType = WindowScreenType::MAIN_SCREEN;
	loadCommonRessources();
	loadMainScreenRessources();
    loadLoadingScreenRessources();
}

void UIHandler::display()
{
    bool initDebug = false; // Console for debug print
    while (_window.isOpen())
    {
        sf::Event event;
        while (_window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                _window.close();
            }

            switch (_screenType)
            {
            case WindowScreenType::MAIN_SCREEN:
                processMainScreenInput(event);
                break;
            case WindowScreenType::LOADING_SCREEN:
                processLoadingScreenInput(event);
                break;
            case WindowScreenType::RESULTS_SCREEN:
                processResultsScreenInput(event);
                break;
            case WindowScreenType::HELP_SCREEN:
                break;
            default:
                break;
            }

        }

        if (!initDebug)
        {
            displayDebugHeader();
            initDebug = true;
        }

        switch (_screenType)
        {
        case WindowScreenType::MAIN_SCREEN:
            computePlatInputPosition();
            break;
        case WindowScreenType::LOADING_SCREEN:
            computeProgress();
            break;
        case WindowScreenType::RESULTS_SCREEN:
            break;
        case WindowScreenType::HELP_SCREEN:
            break;
        default:
            break;
        }

        // Draw elements based on the screen type
        _window.clear();

        drawCommonElements();

        switch (_screenType)
        {
        case WindowScreenType::MAIN_SCREEN:
            drawMainScreenElements();
            break;
        case WindowScreenType::LOADING_SCREEN:
            drawLoadingScreenElements();
            break;
        case WindowScreenType::RESULTS_SCREEN:
        {
            sf::Vector2i position = sf::Mouse::getPosition();
            drawResultsScreenElements(position.x, position.y);
            break;
        }
        case WindowScreenType::HELP_SCREEN:
            break;
        default:
            break;
        }
        
        _window.display();
    }
    return;
}

// COMMON ELEMENTS SECTION
void UIHandler::loadCommonRessources()
{
	if (!_backgroundTexture.loadFromFile("./../../../ressources/Images/StalkerBackground.jpg"))
	{
		std::cout << "Can't load background texture" << std::endl;
	}
	_backgroundSprite.setTexture(_backgroundTexture);

	if (!_textFont.loadFromFile("./../../../ressources/Fonts/rocks_death.ttf"))
	{
		std::cout << "Can't load font" << std::endl;
	}

    if (_platTexture.loadFromFile("./../../../ressources/Images/Plat.png"))
    {
        std::cout << "Can't load plat texture" << std::endl;
    }

    _platTexture.setSmooth(true);

    _helpText.setFont(_textFont);
    _helpText.setString("Press ESC to exit");
    _helpText.setCharacterSize(35);
    _helpText.setFillColor(sf::Color::White);
    _helpText.setPosition(0, 0);

}

void UIHandler::drawCommonElements()
{
    _window.draw(_backgroundSprite);
    _window.draw(_helpText);
}

// MAIN SCREEN SECTION
void UIHandler::loadMainScreenRessources()
{
    _mainScreenTitle.setFont(_textFont);
    _mainScreenTitle.setString("RelicsTracker by Zakelis");
    _mainScreenTitle.setCharacterSize(75);
    _mainScreenTitle.setFillColor(sf::Color::White);
    sf::FloatRect titleBbox = _mainScreenTitle.getGlobalBounds();
    _mainScreenTitle.setPosition((_windowWidth - titleBbox.width) / 2, (_windowHeight - titleBbox.height) / 5);

    _platPrompt.setFont(_textFont);
    _platPrompt.setString("Enter a minimum plat value : ");
    _platPrompt.setCharacterSize(50);
    _platPrompt.setFillColor(sf::Color::White);
    sf::FloatRect promptBbox = _platPrompt.getGlobalBounds();
    _platPrompt.setPosition((_windowWidth - promptBbox.width) / 2, (_windowHeight - promptBbox.height) / 3);

    _platTextInput.setFont(_textFont);
    _platTextInput.setCharacterSize(100);
}

void UIHandler::processMainScreenInput(const sf::Event& event)
{
    if (event.type == sf::Event::TextEntered)
    {
        if (std::isprint(event.text.unicode)
            && ((event.text.unicode > 47 && event.text.unicode < 58)
                || event.text.unicode == 46))
        {
            _platInput += event.text.unicode;
        }
    }
    else if (event.type == sf::Event::KeyPressed)
    {
        if (event.key.code == sf::Keyboard::BackSpace) {
            if (!_platInput.empty())
                _platInput.pop_back();
        }
        else if (event.key.code == sf::Keyboard::Return) {
            if (!_platInput.empty())
            {
                _WAThreshold = std::stod(_platInput);
                if (_WAThreshold > 0)
                {
                    _computationHandler.setWAThreshold(_WAThreshold);
                    _screenType = WindowScreenType::LOADING_SCREEN;
                    _computationThread = std::thread(&ComputationHandler::rebuildCache, &_computationHandler);
                }
            }
        }
        else if (event.key.code == sf::Keyboard::Escape) {
            _window.close();
        }
    }
}

void UIHandler::computePlatInputPosition()
{
    _platTextInput.setString(_platInput);
    sf::FloatRect inputBbox = _platTextInput.getGlobalBounds();
    _platTextInput.setPosition((_windowWidth - inputBbox.width) / 2, (_windowHeight - inputBbox.height) / 2);
}

void UIHandler::drawMainScreenElements()
{
    _window.draw(_mainScreenTitle);
    _window.draw(_platPrompt);
    _window.draw(_platTextInput);
}

// LOADING SCREEN SECTION
void UIHandler::processLoadingScreenInput(const sf::Event& event)
{
    if (event.type == sf::Event::KeyPressed)
    {
        if (event.key.code == sf::Keyboard::Escape) {
            _window.close();
        }
    }
}

void UIHandler::loadLoadingScreenRessources()
{
    _loadingScreenTitle.setFont(_textFont);
    _loadingScreenTitle.setString("Querying results...");
    _loadingScreenTitle.setCharacterSize(75);
    _loadingScreenTitle.setFillColor(sf::Color::White);
    sf::FloatRect titleBbox = _loadingScreenTitle.getGlobalBounds();
    _loadingScreenTitle.setPosition((_windowWidth - titleBbox.width) / 2, (_windowHeight - titleBbox.height) / 4);

    _percentageText.setFont(_textFont);
    _percentageText.setCharacterSize(100);

    _platTexture.setRepeated(true);

    _progressSprite.setTexture(_platTexture);
    _progressSprite.setPosition(210, (_windowHeight - 125) / 2); // Margin on X axis = (1920 - _maxProgressShapeLength) / 2
}

void UIHandler::computeProgress()
{
    if (ComputationHandler::_loadingScreenPercentage == 100)
    {
        loadResultsScreenRessources();
        _screenType = WindowScreenType::RESULTS_SCREEN;
        return;
    }
    _percentageText.setString(std::to_string(ComputationHandler::_loadingScreenPercentage) + "% completed");
    sf::FloatRect textBbox = _percentageText.getGlobalBounds();
    _percentageText.setPosition((_windowWidth - textBbox.width) / 2, (_windowHeight - textBbox.height) * 2 / 3);

    // Margin on X axis = (1920 - _maxProgressShapeLength) / 2
    _progressSprite.setTextureRect({0, 0,
        static_cast<int>(_maxProgressShapeLength * ComputationHandler::_loadingScreenPercentage / 100), 125 });
}

void UIHandler::drawLoadingScreenElements()
{
    _window.draw(_loadingScreenTitle);
    _window.draw(_percentageText);
    _window.draw(_progressSprite);
}

// RESULTS SCREEN SECTION
void UIHandler::loadResultsScreenRessources()
{
    _activeRelicCategory = ActiveRelicCategory::NONE;

    _lithTitle.setFont(_textFont);
    _lithTitle.setString("Lith");
    _lithTitle.setCharacterSize(100);
    _lithTitle.setFillColor(sf::Color::White);
    sf::FloatRect titleBbox = _lithTitle.getGlobalBounds();
    _lithTitle.setPosition(_windowWidth * 0.2 - titleBbox.width / 2, _windowHeight / 4 - titleBbox.height / 2);

    _mesoTitle.setFont(_textFont);
    _mesoTitle.setString("Meso");
    _mesoTitle.setCharacterSize(100);
    _mesoTitle.setFillColor(sf::Color::White);
    titleBbox = _mesoTitle.getGlobalBounds();
    _mesoTitle.setPosition(_windowWidth * 0.4 - titleBbox.width / 2, _windowHeight / 4 - titleBbox.height / 2);

    _neoTitle.setFont(_textFont);
    _neoTitle.setString("Neo");
    _neoTitle.setCharacterSize(100);
    _neoTitle.setFillColor(sf::Color::White);
    titleBbox = _neoTitle.getGlobalBounds();
    _neoTitle.setPosition(_windowWidth * 0.6 - titleBbox.width / 2, _windowHeight / 4 - titleBbox.height / 2);

    _axiTitle.setFont(_textFont);
    _axiTitle.setString("Axi");
    _axiTitle.setCharacterSize(100);
    _axiTitle.setFillColor(sf::Color::White);
    titleBbox = _axiTitle.getGlobalBounds();
    _axiTitle.setPosition(_windowWidth * 0.8 - titleBbox.width / 2, _windowHeight / 4 - titleBbox.height / 2);

    _relicPlaceholderText.setFont(_textFont);
    _relicPlaceholderText.setString("Select a relic category");
    _relicPlaceholderText.setCharacterSize(75);
    _relicPlaceholderText.setFillColor(sf::Color::White);
    titleBbox = _relicPlaceholderText.getGlobalBounds();
    _relicPlaceholderText.setPosition(_windowWidth / 4 - titleBbox.width / 2, _windowHeight / 3 * 2 - titleBbox.height / 2);

    _separatorBetweenRelicsAndRelicsTypes.setSize(sf::Vector2f(_windowWidth, 5));
    _separatorBetweenRelicsAndRelicsTypes.setOutlineColor(sf::Color::White);
    _separatorBetweenRelicsAndRelicsTypes.setOutlineThickness(2);
    _separatorBetweenRelicsAndRelicsTypes.setPosition(0, _windowHeight / 3);

    _separatorBetweenRelicsAndItems.setSize(sf::Vector2f(5, _windowHeight / 3 * 2));
    _separatorBetweenRelicsAndItems.setOutlineColor(sf::Color::White);
    _separatorBetweenRelicsAndItems.setOutlineThickness(2);
    _separatorBetweenRelicsAndItems.setPosition(_windowWidth / 5 * 2.8, _windowHeight / 3);

    _platTexture.setRepeated(false);

    _platSprite.setTexture(_platTexture, true);

    computeRelicsTextPositions(_computationHandler._lithRelics, _lithText);
    computeRelicsTextPositions(_computationHandler._mesoRelics, _mesoText);
    computeRelicsTextPositions(_computationHandler._neoRelics, _neoText);
    computeRelicsTextPositions(_computationHandler._axiRelics, _axiText);
}

void UIHandler::processResultsScreenInput(const sf::Event& event)
{
    if (event.type == sf::Event::KeyPressed)
    {
        if (event.key.code == sf::Keyboard::Escape) {
            _window.close();
        }
    }
    else if (event.type == sf::Event::MouseWheelScrolled)
    {
        if (event.mouseWheelScroll.delta != 0)
        {
            switch (_activeRelicCategory)
            {
            case ActiveRelicCategory::LITH:
                scrollRelicsText(_lithText, event.mouseWheelScroll.delta);
                break;
            case ActiveRelicCategory::MESO:
                scrollRelicsText(_mesoText, event.mouseWheelScroll.delta);
                break;
            case ActiveRelicCategory::NEO:
                scrollRelicsText(_neoText, event.mouseWheelScroll.delta);
                break;
            case ActiveRelicCategory::AXI:
                scrollRelicsText(_axiText, event.mouseWheelScroll.delta);
                break;
            case ActiveRelicCategory::NONE:
                break;
            default:
                break;
            }
        }
    }
    else if (event.type == sf::Event::MouseButtonPressed)
    {
        if (event.mouseButton.button == sf::Mouse::Left)
        {
            sf::Vector2i position = sf::Mouse::getPosition();
            if (changeActiveRelicCategory(_lithTitle, position.x, position.y))
            {
                _activeRelicCategory = ActiveRelicCategory::LITH;
            }
            else if (changeActiveRelicCategory(_mesoTitle, position.x, position.y))
            {
                _activeRelicCategory = ActiveRelicCategory::MESO;
            }
            else if (changeActiveRelicCategory(_neoTitle, position.x, position.y))
            {
                _activeRelicCategory = ActiveRelicCategory::NEO;
            }
            else if (changeActiveRelicCategory(_axiTitle, position.x, position.y))
            {
                _activeRelicCategory = ActiveRelicCategory::AXI;
            }
        }
    }
}

bool UIHandler::changeActiveRelicCategory(sf::Text& _categoryTitle, const int mouseX, const int mouseY)
{
    auto position = _categoryTitle.getPosition();
    auto bounds = _categoryTitle.getGlobalBounds();

    sf::Vector2f mousePosition(mouseX, mouseY);

    if (mousePosition.x >= position.x
        && mousePosition.x <= position.x + bounds.width
        && mousePosition.y >= position.y
        && mousePosition.y <= position.y + bounds.height)
    {
        switch (_activeRelicCategory)
        {
        case ActiveRelicCategory::LITH:
            resetRelicsTextDefaultPositions(_lithText);
            break;
        case ActiveRelicCategory::MESO:
            resetRelicsTextDefaultPositions(_mesoText);
            break;
        case ActiveRelicCategory::NEO:
            resetRelicsTextDefaultPositions(_neoText);
            break;
        case ActiveRelicCategory::AXI:
            resetRelicsTextDefaultPositions(_axiText);
            break;
        case ActiveRelicCategory::NONE:
            break;
        default:
            break;
        }
        return true;
    }
    return false;
}

void UIHandler::computeRelicsTextPositions(const std::map<std::string, std::map<std::string, double>>& relicsMap,
    std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap)
{
    int innerRow = 0;
    int colStartMargin = 200;
    int rowStartMargin = 450;
    int row = 0;
    int col = 0;
    for (auto& relic : relicsMap)
    {
        if (col > 2)
        {
            col = 0;
            ++row;
        }

        sf::Text relicText;
        relicText.setFont(_textFont);
        relicText.setString(relic.first);
        relicText.setCharacterSize(35);
        relicText.setFillColor(sf::Color::White);
        sf::FloatRect relicBbox = relicText.getGlobalBounds();
        relicText.setPosition(colStartMargin + ((_windowWidth / 6) * col) - relicBbox.width / 2,
            rowStartMargin + ((_windowHeight / 6) * row) - relicBbox.height / 2);

        ++col;

        std::vector<sf::Text> itemsText;
        for (auto& item : relic.second)
        {
            std::ostringstream strs;
            strs << item.second;
            std::string str = strs.str();

            sf::Text itemText;
            itemText.setFont(_textFont);
            itemText.setString(item.first + ": " + str);
            itemText.setCharacterSize(35);
            itemText.setFillColor(sf::Color::White);
            sf::FloatRect itemBbox = itemText.getGlobalBounds();
            itemText.setPosition(((_windowWidth / 5) * 3.85) - itemBbox.width / 2,
                rowStartMargin + ((_windowHeight / 8) * innerRow) - relicBbox.height / 2);
            itemsText.emplace_back(itemText);
            ++innerRow;
        }

        innerRow = 0;
        textMap.emplace_back(relicText, itemsText);
    }
}

void UIHandler::resetRelicsTextDefaultPositions(std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap)
{
    int innerRow = 0;
    int colStartMargin = 200;
    int rowStartMargin = 450;
    int row = 0;
    int col = 0;
    for (auto& relic : textMap)
    {
        if (col > 2)
        {
            col = 0;
            ++row;
        }
        
        sf::FloatRect relicBbox = relic.first.getGlobalBounds();
        relic.first.setPosition(colStartMargin + ((_windowWidth / 6) * col) - relicBbox.width / 2,
            rowStartMargin + ((_windowHeight / 6) * row) - relicBbox.height / 2);

        ++col;

        for (auto& itemText : relic.second)
        {
            sf::FloatRect itemBbox = itemText.getGlobalBounds();
            itemText.setPosition(((_windowWidth / 5) * 3.85) - itemBbox.width / 2,
                rowStartMargin + ((_windowHeight / 8) * innerRow) - relicBbox.height / 2);
            ++innerRow;
        }

        innerRow = 0;
    }
}

void UIHandler::scrollRelicsText(std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap,
    const float delta)
{
    for (auto& lith : textMap)
    {
        auto position = lith.first.getPosition();
        lith.first.setPosition(position.x, position.y + (delta * 20));
    }
}

void UIHandler::drawResultsScreenElements(const int mouseX, const int mouseY)
{
    _window.draw(_separatorBetweenRelicsAndRelicsTypes);
    _window.draw(_separatorBetweenRelicsAndItems);
    _window.draw(_lithTitle);
    _window.draw(_mesoTitle);
    _window.draw(_neoTitle);
    _window.draw(_axiTitle);

    switch (_activeRelicCategory)
    {
    case ActiveRelicCategory::LITH:
        displayRelicsMap(_lithText, mouseX, mouseY);
        break;
    case ActiveRelicCategory::MESO:
        displayRelicsMap(_mesoText, mouseX, mouseY);
        break;
    case ActiveRelicCategory::NEO:
        displayRelicsMap(_neoText, mouseX, mouseY);
        break;
    case ActiveRelicCategory::AXI:
        displayRelicsMap(_axiText, mouseX, mouseY);
        break;
    case ActiveRelicCategory::NONE:
        _window.draw(_relicPlaceholderText);
        break;
    default:
        break;
    }
}

void UIHandler::displayRelicsMap(std::vector<std::pair<sf::Text, std::vector<sf::Text>>>& textMap,
    const int mouseX, const int mouseY)
{
    for (auto& relic : textMap)
    {
        auto position = relic.first.getPosition();
        auto bounds = relic.first.getGlobalBounds();
        if (position.y < _windowHeight / 3)
        {
            continue;
        }

        sf::Vector2f mousePosition(mouseX, mouseY);
        _window.draw(relic.first);

        if (mousePosition.x >= position.x
            && mousePosition.x <= position.x + bounds.width
            && mousePosition.y >= position.y
            && mousePosition.y <= position.y + bounds.height)
        {
            for (auto& item : relic.second)
            {
                _window.draw(item);
                auto itemPosition = item.getPosition();
                auto itemBounds = item.getGlobalBounds();
                _platSprite.setPosition(itemPosition.x + itemBounds.width + 10,
                    itemPosition.y - 17.5);
                _window.draw(_platSprite);
            }
        }
    }
}

// DEBUG SECTION
void UIHandler::displayDebugHeader()
{
    std::cout << "*******************************" << std::endl;
    std::cout << "** RelicsTracker by Zakelis  **" << std::endl;
    std::cout << "*******************************" << std::endl << std::endl;
    std::cout << "A practical tool that indicates all relics worthy to refine." << std::endl;
    std::cout << "Using non-static last 48 hours trade values ('Weighted Averages') from warframe.market !" << std::endl;
    std::cout << "Enter a minimum plat value and all drop locations for all eligible items will be shown." << std::endl << std::endl;
    std::cout << "Warning : Setting this entry at a low value (<= 35) can take more than a minute." << std::endl;
    std::cout << "This is because WFM's API only allows 3 requests per second." << std::endl << std::endl;
}