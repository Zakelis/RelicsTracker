// main.cpp : Defines the entry point for the application.
#include "UIHandler.h"
#include <windows.h>

double WAThresholdPrompt()
{
    double newWAP = -1;
    std::cout << "Enter minimum plat price : ";
    std::cin >> newWAP;
    return newWAP;
}

int main()
{

    UIHandler UIHandler;
    UIHandler.display();

    /*bool initDebug = false; // Console for debug print
    int winWidth = 1920;
    int winHeight = 1080;
    sf::RenderWindow window(sf::VideoMode(winWidth, winHeight), "RelicsTracker v.1.3");
    window.setVerticalSyncEnabled(true);

    // Background
    sf::Texture texture;
    if (!texture.loadFromFile("C:/Users/stany/Desktop/RelicsTracker/ressources/Images/StalkerBackground.jpg"))
    {
        std::cout << "Can't load texture" << std::endl;
    }

    sf::Sprite sprite;
    sprite.setTexture(texture);

    // Font
    sf::Font font;
    if (!font.loadFromFile("C:/Users/stany/Desktop/RelicsTracker/ressources/Fonts/rocks_death.ttf"))
    {
        std::cout << "Can't load font" << std::endl;
    }

    // title
    sf::Text title;
    title.setFont(font);
    title.setString("RelicsTracker by Zakelis");
    title.setCharacterSize(75); // in pixels, not points!
    title.setFillColor(sf::Color::White);
    sf::FloatRect titleBbox = title.getGlobalBounds();
    title.setPosition((winWidth - titleBbox.width) / 2, (winHeight - titleBbox.height) / 5); // center horizontally, 1/5 vertically

    // prompt
    sf::Text prompt;
    prompt.setFont(font);
    prompt.setString("Enter a minimum plat value : ");
    prompt.setCharacterSize(50); // in pixels, not points!
    prompt.setFillColor(sf::Color::White);
    sf::FloatRect promptBbox = prompt.getGlobalBounds();
    prompt.setPosition((winWidth - promptBbox.width) / 2, (winHeight - promptBbox.height) / 3); // center horizontally, 1/3 vertically

    // input
    std::string playerInput;
    sf::Text playerText;
    playerText.setFont(font);
    playerText.setCharacterSize(100); // in pixels, not points!
    playerText.setPosition(winWidth / 2, winHeight / 2);

    while (window.isOpen())
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
            {
                window.close();
            }
            else if (event.type == sf::Event::TextEntered)
            {
                if (std::isprint(event.text.unicode))
                {
                    playerInput += event.text.unicode;
                }
            }
            else if (event.type == sf::Event::KeyPressed)
            {
                if (event.key.code == sf::Keyboard::BackSpace) {
                    if (!playerInput.empty())
                        playerInput.pop_back();
                }
                else if (event.key.code == sf::Keyboard::Return) {
                    // execute search ?
                }
                else if (event.key.code == sf::Keyboard::Escape) {
                    window.close();
                }
            }

        }

        if (!initDebug)
        {
            displayHeader();
            initDebug = true;
        }

        playerText.setString(playerInput);
        sf::FloatRect inputBbox = playerText.getGlobalBounds();
        playerText.setPosition((winWidth - inputBbox.width) / 2, (winHeight - inputBbox.height) / 2);

        window.clear();
        window.draw(sprite);
        window.draw(title);
        window.draw(prompt);
        window.draw(playerText);
        window.display();
    }

    return 0;*/


    /*bool displayedHeader = false;
    bool terminate = false;
    bool updatedCache = false; // TODO : prompt for dynamic value, write cached results into a file.
    double WAThreshold = -1;

    ComputationHandler cacheBuilder;

    while (!terminate)
    {
        if (!displayedHeader)
        {
            displayHeader();
            displayedHeader = true;
        }

        if (GetAsyncKeyState(VK_ESCAPE) < 0) {
            terminate = true;
        }

        if (WAThreshold < 0)
        {
            double newWAP = WAThresholdPrompt();
            if (newWAP > 0)
            {
                WAThreshold = newWAP;
            }
        }

        if (!updatedCache && WAThreshold > 0)
        {
            if (cacheBuilder.rebuildCache(WAThreshold))
            {
                updatedCache = true;
            }
        }
    }
    return 0;*/
}