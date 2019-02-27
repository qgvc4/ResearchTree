import ReactDOM from 'react-dom';
import React from 'react';

import {Provider} from 'react-redux';
import {BrowserRouter,Route,Redirect,Switch} from 'react-router-dom';

import LoginForm from './components/Login';
import Feed from './components/Feed';

import store from './store';

import './style/index.css';

ReactDOM.render(
    (<Provider store={store}>
        <BrowserRouter>
            <div>
                <Switch>
                    <Route exact path='/Login' component={LoginForm}></Route>
                    <Route path='/Feed' component={Feed}></Route>                   
                    <Redirect to='/Feed'></Redirect>
                </Switch>
            </div>
        </BrowserRouter>
        </Provider>),        
    document.getElementById('root')
)

