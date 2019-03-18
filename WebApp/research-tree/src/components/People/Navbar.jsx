import React, { Component } from 'react'
// import {Redirect} from 'react-router-dom'
// import {connect} from 'react-redux'

//antd
import { Layout, Menu, Icon } from 'antd';

//c1e791 green


const {Sider,} = Layout;

class NavbarPeople extends Component {
    
    render() {
        
        return (
            <Layout>
                <Sider style={{
                  overflow: 'auto', height: '100%', position: 'fixed', left: 0,
                      background: '#74997a'
                }}
                >
                  <div className="logo" />
                    
                  <Menu theme="" mode="inline" defaultSelectedKeys={['2']} style={{ background: '#74997a', color: 'white' }}>
                    <Menu.Item key="1">
                      <Icon type="user" />
                      <span className="nav-text">Feed</span>
                    </Menu.Item>
                    <Menu.Item key="2">
                      <Icon type="team" />
                      <span className="nav-text">People</span>
                    </Menu.Item>
                    <Menu.Item key="3">
                      <Icon type="shop" />
                      <span className="nav-text">Jobs</span>
                    </Menu.Item>
                    <Menu.Item key="4">
                      <Icon type="bar-chart" />
                      <span className="nav-text">Settings</span>
                    </Menu.Item>
                  
                  </Menu>
                </Sider>
            </Layout>   
        );
    }
}



export default (NavbarPeople);
